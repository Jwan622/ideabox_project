editing a method:
1)add an edit link
-use the position of the idea in the ideas array to create a url
2) the link implies a get request which takes us to app.rb route
3)the route should take us to an edit.erb form. But first we need to pass in the necessary
variables into the edit view. We need to pass in an idea and an id because we need to display
both of those in the view. Make sure the route passes in necessary
local variales. the id in action specifies which url we go to once we hit submit on the edge page.
4) now you see the form, but now you need to save changes. first step is to make a put route
5)create a data hash that takes in the inputs from the form
6)update the idea by calling the class method update
7) redirect back to main page that shows all of the ideas.




questions:
1) syntax for taking the route id from symbolized form to in between the bars
2) what is transaction represent?
3) in the edit view, why do we initially go to action: id. Is that just a necessary intermediate step?
4) is the route put '/:id' ever visible?
5) what does db represent? lets use a pry
6) Idea.new vs new(raw_idea[:title])
