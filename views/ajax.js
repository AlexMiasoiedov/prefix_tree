$(document).ready(function (){
  $('#get-list').on('click', function(){
    $.ajax({
      url: '/list',
      type: 'GET',
      success: function(response){
        console.log('response');
      }
    })
  })
});
