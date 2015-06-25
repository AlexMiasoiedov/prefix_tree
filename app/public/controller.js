      $(document).ready(function (){

        list_request();
        $("form#add-form").on('submit', function(event) {
          event.preventDefault();
          var added_word = document.getElementById("add-text-field").value;
          if (added_word != '' && word_exist(added_word)) {
            add_request(added_word);
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
            url: "/tree",
            type: 'GET',
            async: false
          });
          list_request();
          $("form#add-form").find('input:text').val('');
          $("form#list-form").find('input:text').val('');
        });
      });

      function add_request(word) {
        $.get('/add', $("form#add-form").serialize(), function(request, status) {
          if (status == "success") {
            if($("b#pref").text() != '') {
              if (word.slice(0, pref.length) == pref) $('div#list-output').append("<li>" + word + "</li>");
            } else {
              $('div#list-output').append("<li>" + word + "</li>");
            };
            message = "<b>" + word + "</b> was added!";
            notifications(message);
          };
        });
        $("form#add-form").find('input:text').val('');
      };

      function list_request() {
        $.get('/list', $("#list-form").serialize(), function(data) { parse_json_resp(data); });
      };

      function read_read_zip_word(url) {
        $.get(url, function(data){ parse_json_resp(data); });
      };

      function write_write_zip_request(url) {
        $.get(url);
      };

      function parse_json_resp(json) {
        console.log(json);
            $('div#list-output').empty();
            $.each(JSON.parse(json), function(index, value) {
              $('div#list-output').append("<li>" + value + "</li>");
            });
      };

      function notifications(content){
        $("div#notific").html(content).slideDown().fadeOut(1700);
      };

      function word_exist(added_word) {
        var div_child = $("div#list-output").children();
        for (i = 0; i < div_child.length; i++){
          if (added_word == $(div_child[i]).text()) return false;
        };
        return true;
      };
