<div>
    <table class="min-w-full bg-white">
        <thead>
            <tr>
                <th class="px-4 py-2">Course Name</th>
                <th class="px-4 py-2">Actions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($courses as $course)
                <tr>
                    <td class="border px-4 py-2">{{ $course['name'] }}</td>
                    <td class="border px-4 py-2">
                        <button wire:click="editCourse('{{ $course['id'] }}')">Edit</button>
                        <button wire:click="deleteCourse('{{ $course['id'] }}')">Delete</button>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
