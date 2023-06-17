const CLASSNAME = "-visible";
const TIMEOUT = 3000;
$(document).on("turbolinks:load", () => {
  const CLASSNAME = "-visible";
  const TIMEOUT = 3000;
  const $target = $(".title");

  setInterval(() => {
    $target.addClass(CLASSNAME);
    setTimeout(() => {
      $target.removeClass(CLASSNAME);
    }, TIMEOUT);
  }, TIMEOUT * 2);
});