<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Database;

class FirebaseConnectionController extends Controller
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

    // Hiển thị danh sách người dùng
    public function index()
    {
        $users = $this->database->getReference('users')->getValue();

        return view('admin.users.index', ['users' => $users]);
    }

    // Thêm người dùng
    public function store(Request $request)
    {
        $this->database->getReference('users')->push([
            'name' => $request->name,
            'email' => $request->email,
            'phoneNumber' => $request->phoneNumber
        ]);

        return redirect()->route('admin.users.index')->with('success', 'User added successfully.');
    }

    // Cập nhật người dùng
    public function update(Request $request, $id)
    {
        $this->database->getReference("users/{$id}")->update([
            'name' => $request->name,
            'email' => $request->email,
            'phoneNumber' => $request->phoneNumber
        ]);

        return redirect()->route('admin.users.index')->with('success', 'User updated successfully.');
    }

    // Xóa người dùng
    public function destroy($id)
    {
        $this->database->getReference("users/{$id}")->remove();

        return redirect()->route('admin.users.index')->with('success', 'User deleted successfully.');
    }
    
    //View 
    public function show($id)
    {
        $user = $this->database->getReference("users/{$id}")->getValue();
    
        if (!$user) {
            return redirect()->route('admin.users.index')->with('error', 'User not found.');
        }
    
        $courseHistory = $user['courseStart'] ?? [];
    
        return view('admin.users.show', compact('user', 'courseHistory'));
    }    

}
