<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Exercise extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'type', 'id_less'];

    public function lesson()
    {
        return $this->belongsTo(Lesson::class, 'id_less');
    }

    public function questions()
    {
        return $this->hasMany(Question::class, 'id_ex');
    }
}
