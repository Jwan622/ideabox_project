creating a time:
1) when  we create a idea by hitting submit on form, have a variable that holds time.



editing ideas and sorting idea key points:
Remember:
1) "ideas" in the index view is a key in the database that refers to an array of hashes. We pass "ideas" in locals to use it in the view.
1a) We set ideas = to Idea.all which returns us an array of idea objects?
2) Generally speaking, the each with index in the view, gets us the position of the idea in the database, and we then pass this id into the relevant route. We then can use this id in the route to send to various methods.
3) When editing a view, we click the edit link, which then sends the id of the idea in the database to an edit route.
3a) in the edit route, we take the named parameter's value which was sent in from the view using ERB, and then from the edit view, we send the id value back to a put route where we update the info.
3b) its in the put route that we update the idea. We take the pararms inputs, put them into a hash called data, then we pass the id named parameter value into an update method. The update method takes hte id, uses the id number to update the data in the database using the id's position, adn then swaps the old data with the new data. We pass in id and data into the update method. That's how update works.



edit method:
1) the edit link captures the id of the idea in the database. id is just the position of the idea in the database based on position in the array
2) the edit link takes you to a get '/:id/edit' route where it then takes you to a view. The get route finds an idea object based on the id named parameter and then sends that idea to the edit route along with the id named parameter.
3) the edit view when you hit submit sends you to a put route that does the actual editing. The view only shows the current values of the idea object.
4) The put route takes the inputs from the form in the params hash, and updates the idea in the database using that data and the id. The id without sorting is taken from the home page which lists ideas based on order in the database. So when we update using that same id, it refers to the same idea object.
5) The thing with the sort is that when we send the ideas to the index view, we grab the ideas with the all method, then sort them in the array. So when they get displayed, in the view is when each_with_index is called and so the ids are actually based on the sorted array and not the database. We see the ideas listed in rank order and the ides are also in rank order. The update method on the otherhand takes the id from the ideas that are in sort order and then updates the database using the id. The first id in the view may actually correspond with not the first idea in the database but the5th. So when we like the first idea in the view, we wind up liking the first idea in the database which may not be the right idea.

fix:
1) We add an id attribute to the IDea class.
2) We tell teh Idea what id it has in the Ideastore all method. That all method gets used when creating the index view. Raw_ideas is all the ideas in the database



update method:
-really just is a replacement of a hash in the ideas array in the database.


problem with the former + and rankings system
1) on index view, the ideas are sorted by rank. the ideas of each idea on the page is in order from highest rank to lowerst. The first idea has an id of one since each_with_index is used on the view page. The ideas of the database are sorted in the route before being passed to the view. Then the ideas are assigned ids in the view.
2) remember the id comes from the index page. The id is assigned to an idea on the view when we call each_to_index.
3) So we solve this problem of rankig by attaching an id to every idea before passing it into the views. That way when we sort it, the highest rank id may have an idea.id of 3. That idea.id gets past to the route, whih then gets passed to the update method after we click +. the idea.id gets past to the post route and we update the idea.id idea in the database instead of the sorted order id of the view. 
