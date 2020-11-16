// Toolbar Item 'Add Detail' for detail grid

WulinMaster.actions.AddUser = $.extend({}, WulinMaster.actions.BaseAction, {
  name: "add_user",

  handler: function (e) {
    var self = this;

    var $addUserModal = Ui.headerModal("Invite", {
      onOpenStart: function (modal, trigger) {
        var $modalContent = $(modal).find(".modal-content");
        self.getModelGrid($modalContent);
        $modalContent.css("padding", "0");
      },
    });

    var $modalFooter = Ui.modalFooter("Invite").appendTo($addUserModal);
    $modalFooter
      .find(".confirm-btn")
      .addClass("disabled")
      .on("click", function () {
        self.inviteUserIntoApp($addUserModal.find(".modal-content"));
      });
  },

  getModelGrid: function (modalContentDom) {
    var self = this;
    var screen = this.screen;

    var url = "/users?screen=" + screen;
    $.ajax({
      type: "GET",
      url: url,
    }).success(function (response) {
      modalContentDom.html(response);

      // copy the target's master to detail grid, just replace the operator to 'exclude'
      var gridName = modalContentDom.find(".grid_container").attr("name");
      var grid = gridManager.getGrid(gridName);

      self.setGridHeightInModal(modalContentDom.parent());
    });
  },

  // Invite
  inviteUserIntoApp: function (dialogDom) {
    var self = this;
    var detailGridName = dialogDom.find(".grid_container").attr("name");
    var detailGrid = gridManager.getGrid(detailGridName);
    var detailIds = detailGrid.getSelectedIds();
    var data = {
      user_ids: detailIds,
    };
    $.post("/users/invite", data, function (response) {
      displayNewNotification(response.message);
      dialogDom.parent().modal("close");
      self.target.loader.reloadData();
    });
  },
});

WulinMaster.ActionManager.register(WulinMaster.actions.AddUser);
