<%@ Page Title="PRIMA SYSTEM" MetaDescription="Telerik WebMail" MetaKeywords="telerik webmail,webmail,outlook inspired app" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TelerikWebApplication.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Styles/mail.css" rel="stylesheet" />
      <style type="text/css">
        html .RadGrid .rgMasterTable {
            height: auto;
        }

        .subject {
            position: relative;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FolderContent" runat="Server">
    <nav:FolderNavigationControl runat="server" ID="FolderNavigationControl" />
    <nav:MobileNavigation runat="server" ID="MobileNavigation"></nav:MobileNavigation>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <%--<telerik:RadNavigation runat="server" ID="contactNavigation" Skin="BlackMetroTouch" CssClass="secondaryMenu">
        <Nodes>
            <telerik:NavigationNode Text="New" SpriteCssClass="icon icon-Add-Circle">
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="Reply">
                <Nodes>
                    <telerik:NavigationNode Text="Reply"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Reply All"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Forward"></telerik:NavigationNode>
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="Delete"></telerik:NavigationNode>
            <telerik:NavigationNode Text="Move">
                <Nodes>
                    <telerik:NavigationNode Text="Inbox"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Junk"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Drafts"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Deleted"></telerik:NavigationNode>
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="Junk">
                <Nodes>
                    <telerik:NavigationNode Text="Report Spam"></telerik:NavigationNode>
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode Text="More">
                <Nodes>
                    <telerik:NavigationNode Text="Mark as read"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Mark as unread"></telerik:NavigationNode>
                    <telerik:NavigationNode Text="Print"></telerik:NavigationNode>
                </Nodes>
            </telerik:NavigationNode>
            <telerik:NavigationNode CssClass="rightScndNav">
                <NodeTemplate>
                    <span class="button horizontalBtn" data-command-name="bottom"><span class="icon icon-View-ReadingPane-Down"></span></span>
                    <span class="button verticalBtn" data-command-name="right"><span class="icon icon-View-ReadingPane-Right"></span></span>
                    <telerik:RadSearchBox runat="server" Skin="BlackMetroTouch" Width="340px" DropDownSettings-Height="300px" ID="mainSearch"
                        CssClass="hidden" ShowLoadingIcon="false">
                    </telerik:RadSearchBox>
                    <span class="button searchBtn"><span class="icon icon-Search"></span></span>
                </NodeTemplate>
            </telerik:NavigationNode>
        </Nodes>
    </telerik:RadNavigation>
    <div class="scroller">
        <div class="gridWrapper">
            <telerik:RadGrid runat="server" ID="messages" GridLines="None" Height="100%" OnNeedDataSource="messages_NeedDataSource"
                AutoGenerateColumns="false" AllowMultiRowSelection="true" AllowSorting="true" AllowFilteringByColumn="false">
                <ClientSettings EnableRowHoverStyle="true" AllowKeyboardNavigation="false">
                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    <Selecting AllowRowSelect="true" />
                    <ClientEvents OnGridCreated="initialize" />
                </ClientSettings>
                <MasterTableView DataKeyNames="MessageID">
                    <Columns>
                        <telerik:GridClientSelectColumn HeaderText="Select" UniqueName="Select" HeaderStyle-Width="35px" />
                        <telerik:GridBoundColumn DataField="From" UniqueName="From" HeaderText="From" HeaderStyle-Width="200px" />
                        <telerik:GridBoundColumn DataField="Subject" UniqueName="Subject" HeaderText="Subject" ItemStyle-CssClass="subject" />
                        <telerik:GridBoundColumn DataField="Received" UniqueName="Received" HeaderText="Date" DataFormatString="{0:d/M/yyyy HH:mm:ss}" HeaderStyle-Width="200px" />
                        <telerik:GridTemplateColumn UniqueName="Compact">
                            <ItemTemplate>
                                <div class="mobile-column">
                                    <span class="from"><%# DataBinder.Eval(Container.DataItem, "From") %></span>
                                    <span class="received"><%# DataBinder.Eval(Container.DataItem, "Received") %></span>
                                    <span class="subject-mobile"><%# DataBinder.Eval(Container.DataItem, "Subject") %></span>
                                </div>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

        <telerik:RadContextMenu runat="server" ID="messagesContextMenu">
            <Items>
                <telerik:RadMenuItem Text="Reply" />
                <telerik:RadMenuItem Text="Reply All" />
                <telerik:RadMenuItem Text="Forward" />
                <telerik:RadMenuItem IsSeparator="true" />
                <telerik:RadMenuItem Text="Mark as unread" />
                <telerik:RadMenuItem Text="Mark as read" />
                <telerik:RadMenuItem Text="Delete" />
                <telerik:RadMenuItem Text="Junk" />
                <telerik:RadMenuItem IsSeparator="true" />
                <telerik:RadMenuItem Text="Print" />
            </Items>
        </telerik:RadContextMenu>

        <asp:Panel runat="server" ID="pnlMessage" CssClass="mailDetails">
            <div class="header">
                <div id="subject">Telerik WebMail</div>
                <div id="from">John.Doe@telerik.com</div>
                <div id="recieved"></div>
            </div>
            <div id="body">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
            </div>
        </asp:Panel>
    </div>
    <script type="text/javascript">
        var grid = null;
        var masterTableView = null;

        initialize = function () {
            grid = $find("<%= messages.ClientID %>");
               masterTableView = grid.get_masterTableView();

               hideColumnsInGrid(true);

               $(".rightScndNav .button").on("click", function (e) {
                   changeView(e);
               });
           };

           function hideColumnsInGrid(isTopGrid) {
               var columnCount = masterTableView.get_columns().length - 1;
               var hiddenColumnsUniqName = [];

               if (isTopGrid) {
                   hiddenColumnsUniqName.push("Compact");
               }
               else {
                   hiddenColumnsUniqName.push("From", "Subject", "Received");
               }

               // Show all columns
               for (var i = 0; i <= columnCount; i++) {
                   masterTableView.showColumn(i);
               }

               // hide columns
               for (var j = 0; j < hiddenColumnsUniqName.length; j++) {
                   var columnName = hiddenColumnsUniqName[j];
                   var columnIndex = masterTableView.getColumnByUniqueName(columnName).get_element().cellIndex;
                   masterTableView.hideColumn(columnIndex);
               }
           };

           function changeView(e) {
               var command = $(e.currentTarget).attr("data-command-name");
               var $section = $(".section");

               if (command === "right") {
                   this.hideColumnsInGrid(false);

               } else if (command === "bottom") {
                   this.hideColumnsInGrid(true);
               }
               else {
                   return;
               }

               $section.attr("class", "section");
               $section.addClass(command);
               grid.repaint();
          
           };
    </script>--%>
</asp:Content>
