class MasterPrivilegeDetailUserScreen < WulinMaster::Screen
  path "/privileges"

  grid PrivilegeGrid, width: "47%", height: "100%", css: "position: absolute; bottom: 0; left: 0;"
  grid UsersPrivilegeGrid, width: "53%", height: "100%", css: "position: absolute; bottom: 0; right: 0;", title: "Users for Privilege", master_grid: "PrivilegeGrid", eager_loading: false
end
