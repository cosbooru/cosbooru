import Cookie from './cookie'

$(function() {
  $("#hide-dmail-notice").on("click.danbooru", function(e) {
    var $dmail_notice = $("#dmail-notice");
    $dmail_notice.hide();
    var dmail_id = $dmail_notice.data("id");
    Cookie.put("hide_dmail_notice", dmail_id);
    e.preventDefault();
  });

  $("#hide-verify-account-notice").on("click.danbooru", function(e) {
    $("#verify-account-notice").hide();
    Cookie.put('hide_verify_account_notice', '1', 3 * 24 * 60 * 60);
    e.preventDefault();
  });

  $.widget("ui.dialog", $.ui.dialog, {
    options: {
      classes: { "ui-dialog-content": "thin-scrollbar", }
    }
  });

  if (location.hostname.endsWith("danbooru.me")) {
    location.hostname = "danbooru.donmai.us";
  }
});
