<?php

namespace App\Http\Controllers;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Database;

class ProgressController extends Controller
{
    protected $database;

    public function __construct()
    {
        $path = base_path('storage/firebase/firebase.json');

        if (!file_exists($path)) {
            die("The file path {$path} does not exist.");
        }

        $factory = (new Factory)
            ->withServiceAccount($path)
            ->withDatabaseUri('https://linguamaster-a6aa3-default-rtdb.firebaseio.com');

        $this->database = $factory->createDatabase();
    }

    public function index()
    {
        $languages = $this->database->getReference('languages')->getValue();
        $users = $this->database->getReference('users')->getValue();
        $feedbacks = $this->database->getReference('feedbacks')->getValue();
        $leaderboard = $this->database->getReference('leaderboard')->getValue();

        $courseCount = 0;
        $lessonCount = 0;
        $userCount = 0;
        $feedbackCount = 0;

        if (is_array($languages)) {
            foreach ($languages as $language) {
                if (isset($language['courses']) && is_array($language['courses'])) {
                    $courseCount += count($language['courses']);
                    
                    foreach ($language['courses'] as $course) {
                        if (isset($course['lessons']) && is_array($course['lessons'])) {
                            $lessonCount += count($course['lessons']);
                        }
                    }
                }
            }
        }

        if (is_array($users)) {
            $userCount = count($users);
        }

        if (is_array($feedbacks)) {
            $feedbackCount = count($feedbacks);
        }

        if (is_array($leaderboard)) {
            $leaderboardArray = [];
            foreach ($leaderboard as $userId => $data) {
                $leaderboardArray[] = [
                    'name' => $data['name'],
                    'score' => $data['score'],
                ];
            }
            usort($leaderboardArray, function ($a, $b) {
                return $b['score'] - $a['score'];
            });
            $leaderboardArray = array_slice($leaderboardArray, 0, 10);
        }

        return view('admin.progress', compact('courseCount', 'lessonCount', 'userCount', 'feedbackCount', 'leaderboardArray'));
    }
}

