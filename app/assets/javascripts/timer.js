$(function(){
  var total_time_remain = $("#time-remain").data("time-remain");
  time_remain(total_time_remain);
});

function time_remain(total_in_seconds){
  if (total_in_seconds < 0){
    $("[type='submit']").remove();
    set_time(0,0);
  } else if (total_in_seconds == 0){
    $("form").submit();
    set_time(0,0);
  } else {
    minutes = Math.floor(total_in_seconds / 60);
    seconds = total_in_seconds % 60;
    set_time(seconds, minutes);
    setTimeout(function(){time_remain(total_in_seconds - 1)}, 1000);
  }
  return;
}

function set_time(seconds, minutes){
  $("#minutes").html((minutes));
  $("#seconds").html((seconds));
}
