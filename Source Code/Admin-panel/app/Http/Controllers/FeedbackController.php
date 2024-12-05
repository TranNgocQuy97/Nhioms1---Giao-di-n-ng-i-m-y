<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase\Factory;

class FeedbackController extends Controller
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
        $feedbacksSnapshot = $this->database->getReference('feedbacks')->getSnapshot();
        $feedbacks = [];
    
        foreach ($feedbacksSnapshot->getValue() ?? [] as $key => $feedback) {
            $feedback['key'] = $key; 
            $feedbacks[] = $feedback;
        }
    
        return view('admin.feedbacks.index', ['feedbacks' => $feedbacks]);
    }    

    public function answer(Request $request, $key)
    {
        $this->database->getReference('feedbacks/' . $key)
            ->update([
                'status' => 'resolved',
                'answer' => $request->input('answer'),
            ]);
    
        return redirect()->route('feedback.index')->with('success', 'Feedback has been resolved!');
    }    
}
