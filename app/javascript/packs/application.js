// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import $ from 'jquery';
import "jquery";
import "popper.js";
import "bootstrap";

import "../stylesheets/application";
import "../stylesheets/top";
import "../stylesheets/new_form";
import "../stylesheets/card";
import "../stylesheets/paginate";

Rails.start()
// Turbolinks.start()
ActiveStorage.start()

// 文字アニメーション
$(document).ready(function () {
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