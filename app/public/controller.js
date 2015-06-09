      $(document).ready(function (){

        ajax_form_request('/list', "#list-form");

        $("#add-form").on('submit', function(event) {
          event.preventDefault();
          ajax_form_request('/add', "#add-form");
          ajax_form_request('/list', "#list-form");
          //var added_word = document.getElementById("#text-area");
          //$("#notifications").append(added_word.value);
          //$("#notifications").append($("#add-form").serialize());
        });

        $("#list-form").on('submit', function(event) {
          event.preventDefault();
          ajax_form_request('/list', "#list-form");
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
          ajax_form_request('/list', "#list-form");
        });

        $("#read-zip").on('click', function(event) {
          event.preventDefault();
          ajax_request('read_zip');
          ajax_form_request('/list', "#list-form");
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

      function ajax_form_request(url, id) {
        $.ajax({
          url: url,
          type: 'GET',
          data: $(id).serialize(),
          success: function(resp){
            console.log(resp);
            var arr_from_json = JSON.parse(resp);
            if (id == "#list-form") {
              $('#list-output').empty();
              $.each(arr_from_json, function(index, value) {
                $('#list-output').append("<li>" + value + "</li>");
              });
            }
          }
        });
        $("#add-form").find('input:text').val('');
        $("#list-form").find('input:text').val('');
      };
      