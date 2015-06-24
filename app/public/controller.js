      $(document).ready(function (){

        list_request();
        $("form#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("add-text-field").value;
          var pref = $("b#pref").text();
          //word_exist(added_word)
          if (added_word != '' && word_exist(added_word)) {
            add_request();
            if(pref != '') {
              if (added_word.slice(0, pref.length) == pref) $('div#list-output').append("<li>" + added_word + "</li>");
            } else {
              $('div#list-output').append("<li>" + added_word + "</li>");
            };
          message = "<b>" + added_word + "</b> was added!";
          notifications(message);
          };
        });

        $("form#list-form").on('submit', function(event) {
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

        $("input#write").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_file");
          message = "words was recorded to file";
          notifications(message);
        });

        $("input#write-zip").on('click', function(event) {
          event.preventDefault();
          write_write_zip_request("/write_zip")
          message = "words was recorded to zip file";
          notifications(message);
        });

        $("input#read").on('click', function(event) {
          event.preventDefault();
          read_read_zip_word("/read_file")
          message = "Words from read file was added into tree";
          notifications(message);
        });

        $("input#read-zip").on('click', function(event) {
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
          $("form#add-form").find('input:text').val('');
          $("form#list-form").find('input:text').val('');
        });
      });

      function add_request() {
        $.ajax({
          url: "/add",
          type: "GET",
          data: $("form#add-form").serialize()
        });
        $("form#add-form").find('input:text').val('');
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
            $('div#list-output').empty();
            $.each(arr_from_json, function(index, value) {
              $('div#list-output').append("<li>" + value + "</li>");
            });
      };

      function notifications(content){
        $("div#notific").html(content);
        $("div#notific").slideDown();
        $("div#notific").fadeOut(1700);
      };

      function word_exist(added_word) {
        var div_child = div_child = $("div#list-output").children();
        for (i = 0; i < div_child.length; i++){
          if (added_word == $(div_child[i]).text()) return false;
        };
        return true;
      };
      