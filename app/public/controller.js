      $(document).ready(function (){

        list_request();
        $("#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("add-text-field").value;
          var pref = $("b#pref").text();
          if (added_word != '') {
            add_request();
            if(pref != '') {
              if (added_word.slice(0, pref.length) == pref) $('#list-output').append("<li>" + added_word + "</li>");
            } else {
              $('#list-output').append("<li>" + added_word + "</li>");
            };
          message = "<b>" + added_word + "</b> was added!";
          notifications(message);
          };
        });

        $("#list-form").on('submit', function(event) {
          event.preventDefault();
          var prefix = document.getElementById("list-text-field").value;
          if(prefix != ''){
            message = "List of words with prefix <b>" + prefix + "</b>";
            $("b#pref").html(prefix);
            $("div#prefix").fadeIn();
          }else{
            message = "Words list";
            $("b#pref").html('');
            $("div#prefix").fadeOut();
          };
          notifications(message);
          list_request();
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
          list_request();
          $("#add-form").find('input:text').val('');
          $("#list-form").find('input:text').val('');
        });
      });

      function add_request() {
        $.ajax({
          url: "/add",
          type: "GET",
          data: $("#add-form").serialize()
        });
        $("#add-form").find('input:text').val('');
      };

      function list_request() {
        $.ajax({
          url: "/list",
          type: 'GET',
          data: $("#list-form").serialize(),
          success: function(resp){
            parse_json_resp(resp);
          }
        });
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
