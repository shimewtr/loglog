import Vue from "vue";
import FollowRelationship from "./follow-relationship.vue";

document.addEventListener("DOMContentLoaded", () => {
  const followRelationship = document.getElementById("js-follow-relationship");
  if (followRelationship) {
    const userId = followRelationship.getAttribute("user-id");
    const following = followRelationship.getAttribute("following");
    new Vue({
      render: h => h(FollowRelationship, {
        props: {
          userId: userId,
          following: following,
        }
      })
    }).$mount(followRelationship);
  }
});