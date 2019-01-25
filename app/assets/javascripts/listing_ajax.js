$(document).on("turbolinks:load", function(){
    $("#listing-search").on("keyup", function(){
        autocomplete()
    });
})
  
  function autocomplete(){
    $.ajax({
      url: '/search',
      type: 'POST',
      data: $("#search-form").serialize(), //takes the form data and authenticity toke and converts it into a standard URL
      dataType: 'json', //specify what type of data you're expecting back from the servers
      error: function() {
          console.log("Something went wrong");
      },
      success: function(data) {
        console.log(data)

        $("#list").html("");
  
        data.forEach(function(listing) {
          let option = document.createElement("option");
          option.value = listing.name;
  
          //append option to list
          if ($('option').length < 10) {
              $("#list").append(option);
          }
          option = document.createElement("option");
          option.value = listing.description;
  
          //append option to list
          if ($('option').length < 10) {
              $("#description-list").append(option);
          }
        })
      }
    });
  }
  