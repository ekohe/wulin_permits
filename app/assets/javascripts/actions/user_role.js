// User grid toolbar item 'Role' button, add role to selected user

WulinMaster.actions.UserRole = $.extend({}, WulinMaster.actions.BaseAction, {
  name: 'user_role',

  handler: function() {
    var grid = this.getGrid();

    var rows = grid.getSelectedRows();
    if (rows.length > 0) {
      this.displayUserRolesPopup(grid.getDataItem(rows[0]));
      return false;
    } else {
      displayErrorMessage("Please select an user.");
    }
  },

  displayUserRolesPopup: function(user) {
    var self = this;
    var ajaxOptions = {
      url: "/user_roles?screen=UserRoleScreen&user_id=" + user.id,
      success: self.ajaxOnSuccess
    };
    return $.ajax(ajaxOptions).user = user;
  },

  ajaxOnSuccess: function(data, textStatus, ajaxRequest) {
    var user = ajaxRequest.user;
    var dialogHtml = $("<div/>").attr('id', 'user_role').attr('title', 'User roles for ' + user.email).addClass('ui-state-highlight').css('display', 'none');
    $('body').append(dialogHtml);
    dialogHtml.append(data);

    var dialogOptions = {
      autoOpen: true,
      modal: true,
      width: 600,
      height: 500,
      buttons: {
        "Ok": function() {
          $(this).dialog('close');
          return $("#user_role").remove();
        }
      },
      close: function() {
        return $("#user_role").remove();
      }
    };
    $('#user_role').dialog(dialogOptions);
    return gridManager.getGrid('user').resetActiveCell();
  }
});

WulinMaster.ActionManager.register(WulinMaster.actions.UserRole);