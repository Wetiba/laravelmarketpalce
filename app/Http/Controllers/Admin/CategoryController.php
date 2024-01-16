<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index(){
        $pageTitle = 'All Categories';
        $categories = Category::orderBy('id','desc')->paginate(getPaginate());
        return view('admin.category.index', compact('pageTitle', 'categories'));
    }

    public function save(Request $request, $id=0){
        $request->validate([
            'name' => 'required|max:40',
            'icon' => 'required'
        ]);

        $category = new Category();
        $notification = 'added';
        if($id){
            $category = Category::findOrFail($id);
            $notification = 'updated';
            $category->status = $request->status ? 1 : 0;
        }

        $category->name = $request->name;
        $category->icon = $request->icon;
        $category->save();

        $notify[] = ['success', "Category $notification successfully"];
        return back()->withNotify($notify);
    }
}
