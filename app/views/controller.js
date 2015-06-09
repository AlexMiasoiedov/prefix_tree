$(document).ready(function (){
  $('#list-form').on('submit', function(event){
    $.ajax({
      url: '/list',
      type: 'GET',
      data: $("#list-form").serialize(),
      success: function(resp){
        console.log(resp);
        //$('#list-output').append(resp);
       }
    })
    event.preventDefault();
  })

  $('#add-form').on('submit', function(event){
    $.ajax({
      url: '/add',
      type: 'GET',
      data: $("#add-form").serialize(),
      success: function(resp){
        console.log(resp);
      }
    })
    event.preventDefault();
  })
});
