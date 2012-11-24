$(function () {
  // Sorting and pagination links.
  $('#channels .pagination a').live('click', function () {
      $.getScript(this.href);
      return false;
    }
  );
  
  // Search form.
  $('#channels_search input').keyup(function () {
    $.get($('#channels_search').attr('action'), $('#channels_search').serialize(), null, 'script');
    return false;
  });


});
