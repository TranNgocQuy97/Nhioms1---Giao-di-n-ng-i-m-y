<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Answer extends Model
{
    use HasFactory;

    protected $fillable = ['answer_text', 'is_correct', 'id_ques'];

    public function question()
    {
        return $this->belongsTo(Question::class, 'id_ques');
    }
}
