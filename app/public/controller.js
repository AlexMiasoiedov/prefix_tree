      $(document).ready(function (){

        add_list_request("/list", "#list-form");
        $("#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("add-text-field").value;
          if(added_word != ''){
            message = "<b>" + added_word + "</b> was added!";
            notifications(message);
            add_list_request("/add", "#add-form");
          }
        });

        $("#list-form").on('submit', function(event) {
          event.preventDefault();
          var prefix = document.getElementById("list-text-field").value;
          if(prefix != ''){
            message = "List of words with prefix <b>" + prefix + "</b>";
          }else{
            message = "Words list";
          };
          notifications(message);
          add_list_request("/list", "#list-form");
        });

        $("#write").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_file");
          message = "words was recorded to file";
          notifications(message);
        });

        $("#write-zip").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_zip")
          message = "words was recorded to zip file";
          notifications(message);
        });

        $("#read").on('click', function(event) {
          event.preventDefault();
          read_read_zip_word("/read_file")
          message = "Words from read file was added into tree";
          notifications(message);
        });

        $("#read-zip").on('click', function(event) {
          event.preventDefault();
          read_read_zip_word("/read_zip")
          message = "Words from read zip file was added into tree";
          notifications(message);
        });

        $("input#clear-tree").on('click', function(event) {
          event.preventDefault();
          $.ajax({
            url: '/',
            type: 'GET',
            async: false
          });
          add_list_request("/list", "#list-form");
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

      function notifications(content){
        $("div#notific").html(content);
        $("div#notific").slideDown();
        $("div#notific").fadeOut(1700);
      };
