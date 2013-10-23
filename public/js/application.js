$(document).ready(function() {


  $('#my_tweet').submit(function(event){
    var waiting = ('<p>Processing...</p>');
    $('form').after(waiting);
    event.preventDefault();

    var data = $(this).serialize();
    var url = "/status/create_tweet";

    $.post(url, data, function(response){
      var jid = response.jid;
      console.log(jid);
    }, "json");
    


      console.log(data);

      // $.get('/status/:jid', jid,  function(){

        
        // $.post('/', data, function(  response){
        //   $('p').remove();
        //   $('.textbox').prop('disabled', true);
        //   console.log(response);
        //   $('form').after(data);
        //   $('form').append(response);
      });
    });
  });
});
