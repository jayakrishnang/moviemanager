function toggleWatchStatus(movie_id){
  $.ajax({
    url: '/movies/toggle_marked_status',
    data: {'movie_id': movie_id},
    success: function(data) {
      watchButton = document.getElementById('watch_button_' + movie_id);
      if(watchButton != null){
        if(watchButton.innerHTML == 'SEEN'){
          watchButton.innerHTML = 'UNSEEN';
          watchButton.className = 'btn btn-red';
        }
        else{
          watchButton.innerHTML = 'SEEN';
          watchButton.className = 'btn btn-success';
        }
      }
    }
  });
}