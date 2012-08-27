// User grid toolbar item 'Role' button, add role to selected user

WulinMaster.actions.RolesUser = $.extend({}, WulinMaster.actions.BaseAction, {
  name: 'roles_user',

  handler: function() {
    var grid = this.getGrid();

    var rows = grid.getSelectedRows();
    if (rows.length > 0) {
      this.displayRolesUsersPopup(grid.getDataItem(rows[0]));
      return false;
    } else {
      displayErrorMessage("Please select an user.");
    }
  },

  displayRolesUsersPopup: function(user) {
    var self = this;
    var ajaxOptions = {
      url: "/roles_users?screen=RolesUserScreen&user_id=" + user.id,
      success: self.ajaxOnSuccess
    };
    return $.ajax(ajaxOptions).user = user;
  },

  ajaxOnSuccess: function(data, textStatus, ajaxRequest) {
    var user = ajaxRequest.user;
    var dialogHtml = $("<div/>").attr('id', 'roles_user').attr('title', 'User roles for ' + user.email).addClass('ui-state-highlight').css('display', 'none');
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
          return $("#roles_user").remove();
        }
      },
      close: function() {
        return $("#roles_user").remove();
      }
    };
    $('#roles_user').dialog(dialogOptions);
    return gridManager.getGrid('user').resetActiveCell();
  }
});

WulinMaster.ActionManager.register(WulinMaster.actions.RolesUser);