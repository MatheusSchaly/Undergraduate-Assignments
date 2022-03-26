pos(boss, 15, 15).
checking_cells.
resource_needed(1).


+my_pos(X, Y) : checking_cells & not building_finished
   <- !check_for_resources.


+!check_for_resources : resource_needed(R) & found(R) & my_pos(X, Y)
   <- !stop_checking;
      // Avisa que recurso encontrado, passando local e o recurso, para todos os agentes
      .println("Hey! I found a new resource at X Y: ", X, " ", Y);
      .broadcast(tell, resource(X, Y, R));
      !take(R, boss);
      !continue_mine.


+!check_for_resources : resource_needed(R) & not found(R) & my_pos(X, Y)
   <- .wait(230);
   	move_to(next_cell);
      // Avisa que recurso não foi mais encontrado, passando local e o recurso, para todos os agentes
      .broadcast(untell, resource(X, Y, R)).


+!check_for_resources : resource_needed(R) & found(F) & my_pos(X, Y)
   <- .wait(230);
      // Avisa que resurso encontrado, passando local e o recurso, para todos os agentes
      // mas nesse caso o recurso necessário não é o mesmo que o recurso encontrado
      future_resource(X, Y, R);
      .println("We don't really want resource at: ", X, " ", Y);
      .broadcast(tell, future_resource(X, Y, F));
   	move_to(next_cell).


+resource(X, Y, R) : true
   // Manda agente para a posição X, Y onde o recurso foi encontrado
   <- .println("I know that there is a resource at X Y: ", X, " ", Y);
      .println("The resource type is: ", R);
      // Manda o agente parar de checar
      -checking_cells;
      // Manda o agente ir em direção ao recurso
      !go(X, Y).


+future_resource(X, Y, R) : true
   // Manda agente para a posição X, Y onde o recurso foi encontrado
   <- .println("I know that there is resource that we still don't mine at X Y: ", X, " ", Y);
      .println("The resource type is: ", R).


+resource_needed(R) : resource(X, Y, R)
   <- !go(X, Y).


// Acionado quando a posição do agente estiver sobre o recurso
+!go(X, Y) : my_pos(X, Y) & resource(X, Y, R)
   <- .println("FOUND IT!");
      .wait(230);
      // Minere o recurso
      +checking_cells;
      !stop_checking;
      !take(R, boss);
      !continue_mine.


// Vai em direção ao recurso até encontrá-lo
+!go(X, Y) : true
   <- .println("I am moving towards X Y: ", X, " ", Y);
      .wait(230);
      // Avisa para parar de checar celulas e ir para onde o recurso foi encontrado
      move_towards(X, Y);
      !go(X, Y).


+!go(Position) : pos(Position, X, Y) & my_pos(X, Y)
   <- true.


+!go(Position) : true
   <- ?pos(Position, X, Y);
      .wait(230);
      move_towards(X, Y);
      !go(Position).


+!stop_checking : true
   <- ?my_pos(X, Y);
      +pos(back, X, Y);
      -checking_cells.


+!take(R, B) : true
   <- .wait(230);
   	mine(R);
      !go(B);
      drop(R).


+!continue_mine : true
   <- !go(back);
      -pos(back,X,Y);
      +checking_cells;
      !check_for_resources.


@psf[atomic]
+!search_for(NewResource) : resource_needed(OldResource)
   <- +resource_needed(NewResource);    
      -resource(_, _, OldResource);
      -resource_needed(OldResource).


@pbf[atomic]
+building_finished : true
   <- .drop_all_desires;
      !go(boss).
      
