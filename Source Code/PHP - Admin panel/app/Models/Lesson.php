<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lesson extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'level', 'id_cour'];

    public function course()
    {
        return $this->belongsTo(Course::class, 'id_cour');
    }

    public function exercises()
    {
        return $this->hasMany(Exercise::class, 'id_less');
    }
}
