let IqdbQuery = {};

IqdbQuery.initializePaste = function() {
  if ($("#c-iqdb-queries #a-show").length) {
    $(document).on("paste", IqdbQuery.onPaste);
  }
}

IqdbQuery.initializeAll = function() {
  $(document).on("click.danbooru", "a.toggle-iqdb-posts-low-similarity", function(event) {
    $(".iqdb-low-similarity").toggleClass("hidden");
    $("a.toggle-iqdb-posts-low-similarity").toggle();
    event.preventDefault();
  });
  this.initializePaste();
};

IqdbQuery.onPaste = function(event) {
  if (event.target.classList.contains("no-paste")) return;

  event.preventDefault();
  let clipboardData = (event.clipboardData || event.originalEvent.clipboardData);
  if (typeof clipboardData.files[0] === "undefined") {
    let pastedText = clipboardData.getData("Text");
    $("#search_url").val(pastedText);
  } else {
    let fileInput = document.getElementById("search_file");
    fileInput.files = clipboardData.files;
  }
}

$(() => IqdbQuery.initializeAll());
