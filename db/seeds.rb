# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

home_tag = Tag.create(name: "home")
work_tag = Tag.create(name: "work")
school_tag = Tag.create(name: "school")

todo_one = Todo.create(title: "This is a title", description: "This todo has no tags")
todo_two = Todo.create(title: "This is a todo with a tag", description: "This todo has a tag")
todo_three = Todo.create(title: "This is a completed todo", description: "This todo has no tags", completion: true)

todo_two.tags << home_tag