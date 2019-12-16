import Vue from "vue";
import LogFollowing from "./log-following.vue";

document.addEventListener("turbolinks:load", () => {
  const logFollowing = document.getElementById("js-log-following");
  if (logFollowing) {
    const logId = logFollowing.getAttribute("log-id");
    new Vue({
      render: h => h(LogFollowing, {
        props: {
          logId: logId,
        }
      })
    }).$mount(logFollowing);
  }
});