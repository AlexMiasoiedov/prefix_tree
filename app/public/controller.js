      $(document).ready(function (){

        add_list_request("/list", "#list-form")
        $("#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("text-area").value;
          if(added_word != ''){
            $("b#new-word").html(added_word);
            $("div#notific").slideDown();
            $("div#notific").fadeOut(3000);
            add_list_request("/add", "#add-form")
          }
        });

        $("#list-form").on('submit', function(event) {
          event.preventDefault();
          add_list_request("/list", "#list-form")
        });

        $("#write").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_file")
        });

        $("#write-zip").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_zip")
        });

        $("#read").on('click', function(event) {
          event.preventDefault();
          read_read_zip_word("/read_file")
        });

        $("#read-zip").on('click', function(event) {
          event.preventDefault();
          read_read_zip_word("/read_zip")
        });
      });


      function add_list_request(url, id) {
        $.ajax({
          url: url,
          type: 'GET',
          data: $(id).serialize(),
          success: function(resp){
            parse_json_resp(resp);
          }
        });
        $("#add-form").find('input:text').val('');
        $("#list-form").find('input:text').val('');
      };

      function read_read_zip_word(url) {
        $.ajax({
          url: url,
          type: 'GET',
          success: function(resp){
            parse_json_resp(resp);
          }
        });
      };

      function write_write_zip_request(url) {
        $.ajax({
          url: url,
          type: 'GET',
          success: function(resp){
            console.log(resp);
          }
        });
      };

      function parse_json_resp(json) {
        console.log(json);
            var arr_from_json = JSON.parse(json);
            $('#list-output').empty();
            $.each(arr_from_json, function(index, value) {
              $('#list-output').append("<li>" + value + "</li>");
            });
      };
