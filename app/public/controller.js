      $(document).ready(function (){

        list_request();

        $("#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("text-area").value;
          if(added_word == '') {
            $("b#new-word").append(added_word);
            $("div#notific").slideDown();
            $("div#notific").fadeOut();
            add_word();
          }
        });

        $("#list-form").on('submit', function(event) {
          event.preventDefault();
          list_request();
        });

        $("#write").on('click', function(event) {
          event.preventDefault();
          ajax_request('/write_file');
        });

        $("#write-zip").on('click', function(event) {
          event.preventDefault();
          ajax_request('/write_zip');
        });

        $("#read").on('click', function(event) {
          event.preventDefault();
          ajax_request('read_file');
          list_request();
        });

        $("#read-zip").on('click', function(event) {
          event.preventDefault();
          ajax_request('read_zip');
          list_request();
        });
      });

      function ajax_request(url) {
        $.ajax({
          url: url,
          type: 'GET',
          success: function(resp){
            console.log(resp);
          }
        });
      };

      function list_request() {
        $.ajax({
          url: '/list',
          type: 'GET',
          data: $("#list-form").serialize(),
          success: function(resp){
            console.log(resp);
            var arr_from_json = JSON.parse(resp);
            $('#list-output').empty();
            $.each(arr_from_json, function(index, value) {
              $('#list-output').append("<li>" + value + "</li>");
            });
          }
        });
        $("#add-form").find('input:text').val('');
        $("#list-form").find('input:text').val('');
      };

      function add_word() {
        $.ajax({
          url: '/add',
          type: 'GET',
          data: $("#add-form").serialize(),
          success: function(resp) {
            console.log(resp);
          }
        });
        list_request();
        $("#add-form").find('input:text').val('');
        $("#list-form").find('input:text').val('');
      };
      