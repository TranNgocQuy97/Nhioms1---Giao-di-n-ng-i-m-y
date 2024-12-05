<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Database;

class FirebaseLanguageController extends Controller
{
    private $database;

    public function __construct()
    {
        $factory = (new Factory)
            ->withServiceAccount(base_path('storage/firebase/firebase.json'))
            ->withDatabaseUri('https://linguamaster-a6aa3-default-rtdb.firebaseio.com');
        $this->database = $factory->createDatabase();
    }

    public function index($language)
    {
        $languages = $this->database->getReference('languages')->getValue() ?? [];

        $language = strtoupper($language);

        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });

        if ($languageData) {
            $courses = $languageData['courses'];
        } else {
            $courses = [];
        }

        return view('languages.courses.index', compact('courses', 'language'));
    }

    public function create($language)
    {
        return view('languages.courses.create', compact('language'));
    }

    public function store(Request $request, $language)
    {
        $language = strtoupper($language);

        $ref = $this->database->getReference("languages");

        $languages = $ref->getValue();
        $languageData = null;

        foreach ($languages as $key => $lang) {
            if (strtoupper($lang['name']) == $language) {
                $languageData = $lang;
                break;
            }
        }

        if ($languageData) {
            $newCourse = [
                'id' => uniqid(), 
                'name' => $request->input('name'),
            ];

            $ref->getChild($key)->getChild('courses')->push($newCourse);

            return redirect()->route('languages.courses.index', $language)->with('success', 'Course added successfully.');
        } else {
            return redirect()->route('languages.courses.index', $language)->with('error', 'Language not found.');
        }
    }

    public function edit($language, $courseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
        
        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });
    
        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            if ($course) {
                return view('languages.courses.edit', compact('course', 'language', 'courseId'));
            } else {
                return redirect()->route('languages.courses.index', $language)->with('error', 'Course not found.');
            }
        } else {
            return redirect()->route('languages.courses.index', $language)->with('error', 'Language not found.');
        }
    }
    
    public function update(Request $request, $language, $courseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->filter(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        })->keys()->first();
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'])->filter(function ($course) use ($courseId) {
                return $course['id'] == $courseId;
            })->keys()->first();
    
            if ($courseKey !== null) {
                $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}")
                    ->update([
                        'name' => $request->input('name'),
                    ]);
    
                return redirect()->route('languages.courses.index', $language)->with('success', 'Course updated successfully.');
            } else {
                return redirect()->route('languages.courses.index', $language)->with('error', 'Course not found.');
            }
        } else {
            return redirect()->route('languages.courses.index', $language)->with('error', 'Language not found.');
        }
    }

    public function destroy($language, $courseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
        
        $languageKey = collect($languages)->filter(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        })->keys()->first();

        if ($languageKey !== null) {
            $courses = $languages[$languageKey]['courses'];
            $courseKey = collect($courses)->filter(function ($course) use ($courseId) {
                return $course['id'] === $courseId;
            })->keys()->first();

            if ($courseKey !== null) {
                $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}")->remove();
                return redirect()->route('languages.courses.index', $language)->with('success', 'Course deleted successfully.');
            } else {
                return redirect()->route('languages.courses.index', $language)->with('error', 'Course not found.');
            }
        } else {
            return redirect()->route('languages.courses.index', $language)->with('error', 'Language not found.');
        }
    }

    public function showLessons($language, $courseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();

        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });

        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            if ($course) {
                $lessons = $course['lessons'] ?? [];
                return view('languages.lessons.index', compact('lessons', 'language', 'courseId', 'course'));
            } else {
                return redirect()->route('languages.courses.index', $language)->with('error', 'Course not found.');
            }
        } else {
            return redirect()->route('languages.courses.index', $language)->with('error', 'Language not found.');
        }
    }

    public function createLesson($language, $courseId)
    {
        return view('languages.lessons.create', compact('language', 'courseId'));
    }

    public function storeLesson(Request $request, $language, $courseId)
    {
        $language = strtoupper($language);
        $ref = $this->database->getReference('languages')->getValue();
        
        $languageKey = collect($ref)->filter(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        })->keys()->first();

        if ($languageKey !== null) {
            $courseKey = collect($ref[$languageKey]['courses'])->filter(function ($course) use ($courseId) {
                return $course['id'] == $courseId;
            })->keys()->first();

            if ($courseKey !== null) {
                $newLesson = [
                    'id' => uniqid(),
                    'name' => $request->input('name'),
                    'level' => $request->input('level'),
                ];

                $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons")->push($newLesson);

                return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('success', 'Lesson added successfully.');
            }
        }
        return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Course or Language not found.');
    }

    public function editLesson($language, $courseId, $lessonId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();

        $languageData = collect($languages)->firstWhere('name', strtoupper($language));

        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            
            if ($lesson) {
                return view('languages.lessons.edit', compact('lesson', 'language', 'courseId', 'lessonId'));
            }
        }
        return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Lesson not found.');
    }

    public function updateLesson(Request $request, $language, $courseId, $lessonId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->keys()->first(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'])->keys()->first(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}")
                        ->update([
                            'name' => $request->input('name'),
                            'level' => $request->input('level'),
                        ]);
    
                    return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('success', 'Lesson updated successfully.');
                }
            }
        }
        
        return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Lesson not found.');
    }    

    public function destroyLesson($language, $courseId, $lessonId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->keys()->first(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}")->remove();
                    return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('success', 'Lesson deleted successfully.');
                }
            }
        }
        
        return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Lesson not found.');
    }    

    public function showExercises($language, $courseId, $lessonId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });
    
        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            
            if ($lesson) {
                $exercises = $lesson['exercises'] ?? [];
                return view('languages.exercises.index', compact('exercises', 'language', 'courseId', 'lessonId', 'lesson'));
            } else {
                return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Lesson not found.');
            }
        } else {
            return redirect()->route('languages.courses.lessons.index', [$language, $courseId])->with('error', 'Language not found.');
        }
    }    
      
    public function createExercise($language, $courseId, $lessonId)
    {
        return view('languages.exercises.create', compact('language', 'courseId', 'lessonId'));
    }    

    public function storeExercise(Request $request, $language, $courseId, $lessonId)
    {
        $language = strtoupper($language);
        $ref = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($ref)->filter(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        })->keys()->first();
    
        if ($languageKey !== null) {
            $courseKey = collect($ref[$languageKey]['courses'])->filter(function ($course) use ($courseId) {
                return $course['id'] == $courseId;
            })->keys()->first();
    
            if ($courseKey !== null) {
                $lessonKey = collect($ref[$languageKey]['courses'][$courseKey]['lessons'])->filter(function ($lesson) use ($lessonId) {
                    return $lesson['id'] == $lessonId;
                })->keys()->first();
    
                if ($lessonKey !== null) {
                    $newExercise = [
                        'id' => uniqid(),
                        'name' => $request->input('name'),
                        'type' => $request->input('type'),
                    ];
    
                    $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises")->push($newExercise);
    
                    return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('success', 'Exercise added successfully.');
                }
            }
        }
    
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Lesson not found.');
    }       

    public function editExercise($language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageData = collect($languages)->firstWhere('name', strtoupper($language));
    
        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            $exercise = collect($lesson['exercises'] ?? [])->firstWhere('id', $exerciseId);
            
            if ($exercise) {
                return view('languages.exercises.edit', compact('exercise', 'language', 'courseId', 'lessonId', 'exerciseId'));
            }
        }
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Exercise not found.');
    }      

    public function updateExercise(Request $request, $language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->keys()->first(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'])->keys()->first(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $exerciseKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseId) {
                        return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$key]['id'] == $exerciseId;
                    });
    
                    if ($exerciseKey !== null) {
                        $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises/{$exerciseKey}")
                            ->update([
                                'name' => $request->input('name'),
                                'type' => $request->input('type'),
                            ]);
    
                        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('success', 'Exercise updated successfully.');
                    }
                }
            }
        }
    
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Exercise not found.');
    }      

    public function destroyExercise($language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->keys()->first(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $exerciseKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseId) {
                        return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$key]['id'] == $exerciseId;
                    });
    
                    if ($exerciseKey !== null) {
                        $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises/{$exerciseKey}")->remove();
                        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('success', 'Exercise deleted successfully.');
                    }
                }
            }
        }
    
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Exercise not found.');
    }    

    public function showQuestions($language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();

        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });

        if ($languageData) {
            $course = collect($languageData['courses'])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            $exercise = collect($lesson['exercises'] ?? [])->firstWhere('id', $exerciseId);

            if ($exercise) {
                $questions = $exercise['questions'] ?? [];
                return view('languages.questions.index', compact('questions', 'language', 'courseId', 'lessonId', 'exerciseId', 'exercise'));
            } else {
                return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Exercise not found.');
            }
        } else {
            return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Language not found.');
        }
    }

    public function createQuestion($language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
        
        $languageData = collect($languages)->firstWhere('name', $language);
        if ($languageData) {
            $course = collect($languageData['courses'] ?? [])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            $exercise = collect($lesson['exercises'] ?? [])->firstWhere('id', $exerciseId);
    
            if ($exercise) {
                $exerciseType = $exercise['type'];
                return view('languages.questions.create', compact('language', 'courseId', 'lessonId', 'exerciseId', 'exerciseType'));
            }
        }
        
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Exercise not found.');
    }    

    public function storeQuestion(Request $request, $language, $courseId, $lessonId, $exerciseId)
    {
        $language = strtoupper($language);
        $ref = $this->database->getReference('languages')->getValue();
        
        $languageKey = collect($ref)->keys()->first(function ($key) use ($ref, $language) {
            return strtoupper($ref[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($ref[$languageKey]['courses'])->keys()->firstWhere(function ($key) use ($ref, $languageKey, $courseId) {
                return $ref[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($ref[$languageKey]['courses'][$courseKey]['lessons'])->keys()->firstWhere(function ($key) use ($ref, $languageKey, $courseKey, $lessonId) {
                    return $ref[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $exerciseKey = collect($ref[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'])->keys()->firstWhere(function ($key) use ($ref, $languageKey, $courseKey, $lessonKey, $exerciseId) {
                        return $ref[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$key]['id'] == $exerciseId;
                    });
    
                    if ($exerciseKey !== null) {
                        $newQuestion = [
                            'id' => uniqid(),
                            'name' => $request->input('name'),
                            'question' => $request->input('question'),
                            'audio_url' => $request->input('audio_url'),
                            'video_url' => $request->input('video_url'),
                        ];
    
                        if ($exerciseType == 'Choose correct answer') {
                            $newQuestion['options'] = explode(',', $request->input('options'));
                            $newQuestion['correct_answer'] = $request->input('correct_answer');
                        }
    
                        $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises/{$exerciseKey}/questions")->push($newQuestion);
    
                        return redirect()->route('languages.courses.lessons.exercises.questions.index', [$language, $courseId, $lessonId, $exerciseId])
                                         ->with('success', 'Question added successfully.');
                    }
                }
            }
        }
        
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])
                         ->with('error', 'Exercise not found.');
    }       

    public function editQuestion($language, $courseId, $lessonId, $exerciseId, $questionId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageData = collect($languages)->firstWhere('name', $language);
        if ($languageData) {
            $course = collect($languageData['courses'] ?? [])->firstWhere('id', $courseId);
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            $exercise = collect($lesson['exercises'] ?? [])->firstWhere('id', $exerciseId);
            $question = collect($exercise['questions'] ?? [])->firstWhere('id', $questionId);
    
            if ($question) {
                $exerciseType = $exercise['type'];
                return view('languages.questions.edit', compact('question', 'language', 'courseId', 'lessonId', 'exerciseId', 'questionId', 'exerciseType'));
            }
        }
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId, $exerciseId])->with('error', 'Question not found.');
    }    

    public function updateQuestion(Request $request, $language, $courseId, $lessonId, $exerciseId, $questionId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
        
        $languageKey = collect($languages)->keys()->firstWhere(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'])->keys()->firstWhere(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'])->keys()->firstWhere(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $exerciseKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'])->keys()->firstWhere(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseId) {
                        return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$key]['id'] == $exerciseId;
                    });
    
                    if ($exerciseKey !== null) {
                        $questionKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$exerciseKey]['questions'])->keys()->firstWhere(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseKey, $questionId) {
                            return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$exerciseKey]['questions'][$key]['id'] == $questionId;
                        });
    
                        if ($questionKey !== null) {
                            $updateData = [
                                'name' => $request->input('name'),
                                'question' => $request->input('question'),
                                'correct_answer' => $request->input('correct_answer'),
                                'options' => $request->input('options'),
                                'audio_url' => $request->input('audio_url'),
                                'video_url' => $request->input('video_url'),
                            ];
    
                            if ($request->hasFile('audio')) {
                                $updateData['audio'] = $this->uploadFile($request->file('audio'));
                            }
    
                            if ($request->hasFile('video')) {
                                $updateData['video'] = $this->uploadFile($request->file('video'));
                            }
    
                            $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises/{$exerciseKey}/questions/{$questionKey}")->update($updateData);
    
                            return redirect()->route('languages.courses.lessons.exercises.questions.index', [$language, $courseId, $lessonId, $exerciseId])
                                             ->with('success', 'Question updated successfully.');
                        }
                    }
                }
            }
        }
    
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])
                         ->with('error', 'Question not found.');
    }       

    public function destroyQuestion($language, $courseId, $lessonId, $exerciseId, $questionId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        $languageKey = collect($languages)->keys()->first(function ($key) use ($languages, $language) {
            return strtoupper($languages[$key]['name']) == $language;
        });
    
        if ($languageKey !== null) {
            $courseKey = collect($languages[$languageKey]['courses'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseId) {
                return $languages[$languageKey]['courses'][$key]['id'] == $courseId;
            });
    
            if ($courseKey !== null) {
                $lessonKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonId) {
                    return $languages[$languageKey]['courses'][$courseKey]['lessons'][$key]['id'] == $lessonId;
                });
    
                if ($lessonKey !== null) {
                    $exerciseKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseId) {
                        return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$key]['id'] == $exerciseId;
                    });
    
                    if ($exerciseKey !== null) {
                        $questionKey = collect($languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$exerciseKey]['questions'] ?? [])->keys()->first(function ($key) use ($languages, $languageKey, $courseKey, $lessonKey, $exerciseKey, $questionId) {
                            return $languages[$languageKey]['courses'][$courseKey]['lessons'][$lessonKey]['exercises'][$exerciseKey]['questions'][$key]['id'] == $questionId;
                        });
    
                        if ($questionKey !== null) {
                            $this->database->getReference("languages/{$languageKey}/courses/{$courseKey}/lessons/{$lessonKey}/exercises/{$exerciseKey}/questions/{$questionKey}")->remove();
                            return redirect()->route('languages.courses.lessons.exercises.questions.index', [$language, $courseId, $lessonId, $exerciseId])->with('success', 'Question deleted successfully.');
                        }
                    }
                }
            }
        }
    
        return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId])->with('error', 'Question not found.');
    }
    
    public function showQuestionDetails($language, $courseId, $lessonId, $exerciseId, $questionId)
    {
        $language = strtoupper($language);
        $languages = $this->database->getReference('languages')->getValue();
    
        if (!$languages) {
            return redirect()->route('languages.index')->with('error', 'No languages found.');
        }
    
        $languageData = collect($languages)->first(function ($lang) use ($language) {
            return strtoupper($lang['name']) == $language;
        });
    
        if ($languageData) {
            $course = collect($languageData['courses'] ?? [])->firstWhere('id', $courseId);
            if (!$course) {
                return redirect()->route('languages.index')->with('error', 'Course not found.');
            }
    
            $lesson = collect($course['lessons'] ?? [])->firstWhere('id', $lessonId);
            if (!$lesson) {
                return redirect()->route('languages.courses.index', [$language, $courseId])->with('error', 'Lesson not found.');
            }
    
            $exercise = collect($lesson['exercises'] ?? [])->firstWhere('id', $exerciseId);
            if (!$exercise) {
                return redirect()->route('languages.courses.lessons.index', [$language, $courseId, $lessonId])
                    ->with('error', 'Exercise not found.');
            }
    
            $question = collect($exercise['questions'] ?? [])->firstWhere('id', $questionId);
            if (!$question) {
                return redirect()->route('languages.courses.lessons.exercises.index', [$language, $courseId, $lessonId, $exerciseId])
                    ->with('error', 'Question not found.');
            }
    
            if (!empty($question['audio_url'])) {
                $question['audio_url'] = str_replace('open?', 'uc?', $question['audio_url']);
            }
    
            $exerciseType = $exercise['type'];
            return view('languages.questions.view', compact('question', 'exerciseType', 'language', 'courseId', 'lessonId', 'exerciseId', 'questionId'));
        } else {
            return redirect()->route('languages.index')->with('error', 'Language not found.');
        }
    }    
}
