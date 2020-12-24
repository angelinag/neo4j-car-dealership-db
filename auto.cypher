// Create Car nodes with data

Create (car1:Car {c_id:'01', brand:'Mercedes', color: 'metallic', doors:4})

Create (car2:Car {c_id:'02', brand:'BMW', color: 'black', doors:4})

Create (car3:Car {c_id:'03', brand:'Toyota', color: 'red', doors:2})

// Create Buyer nodes with data

Create (buyer1:Buyer {b_id:'01', name:'Ivan Petrov', preferredbrand:'BMW', dateofbirth:'1980-09-12'})

Create (buyer2:Buyer {b_id:'02', name:'Martin Simeonob', preferredbrand:'Mercedes', dateofbirth:'1987-06-31'})

Create (buyer3:Buyer {b_id:'03', name:'Veselin Nikolaev', preferredbrand:'Toyota', dateofbirth:'1973-12-13'})

// Create Dealer nodes with data

Create(dealer1:Dealer {d_id:'01', name:'Tsvetelin Vanev', experiencelevel:'junior'})

Create(dealer2:Dealer {d_id:'02', name:'Kristian Georgiev', experiencelevel:'senior'})

Create(dealer3:Dealer {d_id:'03', name:'Hristo Tsvetarov', experiencelevel:'senior'})

// Make the relationships between cars and buyers based on their preferred brand

Match (c:Car), (b:Buyer)
Where c.brand='BMW' and b.preferredbrand='BMW'
Create (b)-[p:PREFERS {brand:'BMW'}]->(c)
Return c,b

Match (c:Car), (b:Buyer)
Where c.brand='Mercedes' and b.preferredbrand='Mercedes'
Create (b)-[p:PREFERS {brand:'Mercedes'}]->(c)
Return c,b

Match (c:Car), (b:Buyer)
Where c.brand='Toyota' and b.preferredbrand='Toyota'
Create (b)-[p:PREFERS {brand:'Toyota'}]->(c)
Return c,b

// Create the relationships between cars and their respective dealers

Match (c:Car), (d:Dealer)
Where c.brand='BMW' and d.experiencelevel='senior'
Create (d)-[s:SELLS {brand:'BMW'}]->(c)
Return c,d

Match (c:Car), (d:Dealer)
Where c.brand='Mercedes' and d.name='Kristian Georgiev'
Create (d)-[s:SELLS {brand:'Mercedes'}]->(c)
Return c,d

Match (c:Car), (d:Dealer)
Where c.brand='Toyota' and d.experiencelevel='junior'
Create (d)-[s:SELLS {brand:'Toyota'}]->(c)
Return c,d

// Some sample queries

// Returns all the cars

Match (c:Car)
return c.c_id, c.brand, c.color, c.doors

// Returns all the buyers

Match (b:Buyer)
Return b.b_id, b.name, b.preferredbrand, b.dateofbirth

// Returns all dealers

Match (d:Dealer)
Return d.d_id, d.name, d.experiencelevel

// Returns all experienced dealers

Match (d:Dealer)
Where d.experiencelevel='senior'
Return d.d_id, d.name

// Returns all inexperienced dealers

Match (d:Dealer)
Where d.experiencelevel='junior'
Return d.d_id, d.name

// Returns all buyers who prefer Toyota (using node property)

Match (b:Buyer)
Where b.preferredbrand='Toyota'
Return b.b_id, b.name, b.dateofbirth

// Returns all Mercedes cars

Match (c:Car)
Where c.brand='Mercedes'
Return c.c_id, c.color, c.doors

// Returns all 4-door cars

Match (c:Car)
Where c.doors=4
Return c.c_id, c.color, c.brand

// Returns all buyers who prefer Mercedes (using relationship check)

Match (b:Buyer)-[p:PREFERS]->(c:Car {brand:'Mercedes'})
Return b.b_id, b.name, b.dateofbirth

// Returns all dealers who sell BMW (using relationship check)

Match (d:Dealer)-[s:SELLS]->(c:Car {brand:'BMW'})
Return d.d_id, d.name, d.experiencelevel
