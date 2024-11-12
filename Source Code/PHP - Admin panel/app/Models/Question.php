<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'id_ex', 'video_url', 'audio_url'];

    public function exercise()
    {
        return $this->belongsTo(Exercise::class, 'id_ex');
    }

    public function answers()
    {
        return $this->hasMany(Answer::class, 'id_ques');
    }
}
