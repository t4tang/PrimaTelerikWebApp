<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="entry.ascx.cs" Inherits="TelerikWebApplication.Form.Preventive_maintenance.WorkOrder.entry" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<link href="../../../Styles/custom-cs.css" rel="stylesheet" />

<div style="padding: 10px 5px 3px 15px;" class="entryFormStyle">
    <table id="Table1" border="0" style="border-collapse: collapse; padding-top:5px; padding-left:15px; 
        padding-right:15px; padding-bottom:0px; font-size:smaller;">    
        <tr style="vertical-align: top;">
            <td style="vertical-align: top;">
                <table id="Table2" width="Auto" border="0" class="module"> 
                    <tr>
                        <td colspan="2" style="padding: 0px 0px 10px 5px; text-align:left">
                            <asp:Button ID="btnUpdate" BorderStyle="NotSet" BorderWidth="1px" Width="100px" OnClick="btn_save_Click" Height="25px" 
                                Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
                                ForeColor="DeepSkyBlue" BackColor="Transparent" >
                            </asp:Button>&nbsp;
                            
                            <asp:Button ID="btnCancel" BorderStyle="NotSet" BorderWidth="1px" Width="100px" Height="25px" 
                                Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                runat="server" CausesValidation="False" CommandName="Cancel" ForeColor="DeepSkyBlue" BackColor="Transparent"></asp:Button>
                        </td>
                    </tr>               
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Reg. Number" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txt_reg_number" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.trans_id") %>'
                                    Skin="Telerik"  EmptyMessage="Let it blank" >
                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                            </telerik:RadTextBox>
                        </td>
                    </tr>             
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Doc. Date " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="dtp_doc_date" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtp_doc_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.trans_date") %>'
                                TabIndex="4" Skin="Telerik" > 
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                <FocusedStyle Resize="None"></FocusedStyle>
                                <DisabledStyle Resize="None"></DisabledStyle>
                                <InvalidStyle Resize="None"></InvalidStyle>
                                <HoveredStyle Resize="None"></HoveredStyle>
                                <EnabledStyle Resize="None"></EnabledStyle>
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Est. Exct " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="dtp_estExct" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtp_estExct" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.EstExcDate") %>'
                                TabIndex="4" Skin="Telerik">
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"> 
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Status " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="cb_status" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" ID="cb_status" runat="server" Width="150"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" Skin="Telerik"
                                Text='<%# DataBinder.Eval(Container, "DataItem.statusName") %>' 
                                OnItemsRequested="cb_status_ItemsRequested"
                                OnSelectedIndexChanged="cb_status_SelectedIndexChanged"
                                OnPreRender="cb_status_PreRender" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Priority " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_priority" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>                              
                                <telerik:RadComboBox RenderMode="Lightweight" ID="cb_priority" runat="server" Width="150px"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" AutoPostBack="false" CausesValidation="false" Skin="Telerik" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.prio_desc") %>'
                                OnItemsRequested="cb_priority_ItemsRequested"
                                OnSelectedIndexChanged="cb_priority_SelectedIndexChanged"
                                OnPreRender="cb_priority_PreRender"
                                EnableVirtualScrolling="true" >
                                </telerik:RadComboBox>
                        </td>
                    </tr>
                      <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Project " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="cb_project" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td style="vertical-align:top; text-align:left">
                            <%--<asp:UpdatePanel runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                    Text='<%# DataBinder.Eval(Container, "DataItem.region_name") %>'
                                    ID="cb_project" 
                                    Width="250px" 
                                    AutoPostBack="true"
                                    OnItemsRequested="cb_project_ItemsRequested"
                                    OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                    OnPreRender="cb_project_PreRender" >
                                    </telerik:RadComboBox>
                               <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                                           
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Ref. Number" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td style="vertical-align:top; text-align:left">
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"  
                                Text='<%# DataBinder.Eval(Container, "DataItem.pm_id") %>'
                                DropDownWidth="1000px" 
                                ID="cb_reff" 
                                Width="250px"
                                AutoPostBack="true" 
                                DataTextField="PM_id" 
                                DataValueField="PM_id"                                                 
                                OnSelectedIndexChanged="cb_reff_SelectedIndexChanged"
                                OnItemsRequested="cb_reff_ItemsRequested">
                                <HeaderTemplate>
                                    <table style="width: 1000px">
                                        <tr>
                                            <td style="width: 90px;">
                                                Req. Code
                                            </td>
                                            <td style="width: 70px;">
                                                Date
                                            </td> 
                                            <td style="width: 80px;">
                                                Unit Code
                                            </td>
                                            <td style="width: 60px;">
                                                Unit Status
                                            </td> 
                                            <td style="width: 120px;">
                                                Order Type
                                            </td>
                                            <td style="width: 560px;">
                                                Problem
                                            </td>                                                                    
                                        </tr>
                                    </table>                                                       
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <table style="width: 1000px">
                                        <tr>
                                            <td style="width: 90px;">
                                                <%# DataBinder.Eval(Container, "DataItem.PM_id")%>
                                            </td>
                                            <td style="width: 70px;">
                                                <%# DataBinder.Eval(Container, "DataItem.Req_date","{0:dd/MM/yyyy}")%>
                                            </td>
                                            <td style="width: 100px;">
                                                <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                            </td>
                                            <td style="width: 60px;">
                                                <%# DataBinder.Eval(Container, "DataItem.unitstatus")%>
                                            </td>
                                            <td style="width: 110px;">
                                                <%# DataBinder.Eval(Container, "DataItem.Notif_type_name")%>
                                            </td>
                                            <td style="width: 560px;">
                                                <%# DataBinder.Eval(Container, "DataItem.remark")%>
                                            </td>                                                                
                                        </tr>
                                    </table>
                                </ItemTemplate>                                            
                            </telerik:RadComboBox>                    
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Req. Date" CssClass="lbObject" ></telerik:RadLabel>
                        </td>
                        <td>
                           
                            <telerik:RadTextBox ID="txt_reqDate" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight" Skin="Telerik"   
                                 >
                                <EmptyMessageStyle CssClass="MyEmptyTextBox"></EmptyMessageStyle>
                                <EnabledStyle CssClass="MyEnabledTextBox"></EnabledStyle>
                                <FocusedStyle CssClass="MyFocusedTextBox"></FocusedStyle>
                                <HoveredStyle CssClass="MyHoveredTextBox"></HoveredStyle>
                                <InvalidStyle CssClass="MyInvalidTextBox"></InvalidStyle>
                            </telerik:RadTextBox>
                        </td>
                    </tr>--%>
                    
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Unit " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_unit" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>                                
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                    CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                    Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>'
                                    ID="cb_unit" Width="250px" 
                                    AutoPostBack="true" 
                                    DropDownWidth="250px"                                           
                                    OnItemsRequested="cb_unit_ItemsRequested" 
                                    OnSelectedIndexChanged="cb_unit_SelectedIndexChanged"
                                    OnPreRender="cb_unit_PreRender">
                                    <HeaderTemplate>
                                        <table style="width: 250px; font-size: smaller">
                                            <tr>
                                                <td style="width: 100px;">Unit Code
                                                </td>
                                                <td style="width: 150px;">Model No.
                                                </td>
                                            </tr>
                                        </table>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <table style="width: 250px; font-size: smaller">
                                            <tr>
                                                <td style="width: 100px;">
                                                    <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                </td>
                                                <td style="width:150px;">
                                                    <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                </td>
                                            </tr>
                                        </table>

                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                            </telerik:RadComboBox>
                                
                        </td>
                    </tr>
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Model No " CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txt_unit_name" runat="server" Width="150px" ReadOnly="true" RenderMode="Lightweight" 
                            Text='<%# DataBinder.Eval(Container, "DataItem.model_no") %>' Skin="Telerik">
                            </telerik:RadTextBox>                           
                        </td>
                    </tr>
                    
                    
                </table>
            </td>
            <td style="vertical-align: top; padding-left:15px">
                <table id="Table3" border="0" class="module">
                    <%-- <tr>
                        <td colspan="2" style="padding:0px 0px 4px 0px">
                            <telerik:RadLabel runat="server" Text="Job" Font-Size="Small" Font-Underline="true"  Font-Bold="true" ForeColor="deepskyblue"></telerik:RadLabel>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="width:130px">
                            <telerik:RadLabel runat="server" Text="HM reading " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="hmValidator" ControlToValidate="txt_hm" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txt_hm" runat="server" Width="100px" ReadOnly="false" RenderMode="Lightweight"
                                DBValue='<%# DataBinder.Eval(Container, "DataItem.time_reading") %>' 
                                ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                AutoPostBack="false" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" Skin="Telerik">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="HM Est. Accum. " CssClass="lbObject"></telerik:RadLabel>
                                  
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="txt_hmEstAccum" runat="server" Width="100px" ReadOnly="true" RenderMode="Lightweight"
                                DBValue='<%# DataBinder.Eval(Container, "DataItem.hmEstAccum") %>'  
                                ItemStyle-HorizontalAlign="Right" NumberFormat-AllowRounding="true" EnabledStyle-HorizontalAlign="Right"
                                onkeydown="blurTextBox(this, event)" NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"
                                AutoPostBack="false" MaxLength="11" Type="Number"
                                NumberFormat-DecimalDigits="2" Skin="Telerik">
                            </telerik:RadNumericTextBox>
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Order Type " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_orderType" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                               
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.OrderName") %>' 
                                ID="cb_orderType" 
                                Width="250px" 
                                AutoPostBack="true"
                                DropDownWidth="250px" ForeColor="#003300"
                                OnItemsRequested="cb_orderType_ItemsRequested" 
                                OnSelectedIndexChanged="cb_orderType_SelectedIndexChanged"
                                OnPreRender="cb_orderType_PreRender">
                            </telerik:RadComboBox>
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Job Type " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="cb_jobType" ForeColor="Red" 
                                Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true" 
                                Text='<%# DataBinder.Eval(Container, "DataItem.PMAct_Name") %>' 
                                ID="cb_jobType" 
                                Width="250px" 
                                AutoPostBack="false" 
                                DropDownWidth="250px"
                                OnItemsRequested="cb_jobType_ItemsRequested" 
                                OnSelectedIndexChanged="cb_jobType_SelectedIndexChanged"
                                OnPreRender="cb_jobType_PreRender">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="JSA" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.jsa_name") %>' 
                                ID="cb_jsa" 
                                Width="250px" 
                                AutoPostBack="false"
                                DropDownWidth="450px"                                             
                                OnItemsRequested="cb_jsa_ItemsRequested"
                                OnSelectedIndexChanged="cb_jsa_SelectedIndexChanged"
                                OnPreRender="cb_jsa_PreRender" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>

                    <%--<tr>
                        <td colspan="2" style="padding:7px 0px 4px 0px">
                            <telerik:RadLabel runat="server" Text="Component" Font-Size="Small" Font-Bold="true" Font-Underline="true" ForeColor="deepskyblue"></telerik:RadLabel>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="width:130px">
                            <telerik:RadLabel runat="server" Text="Comp. Group " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="projectValidator" ControlToValidate="cb_compGroup" ForeColor="Red" 
                            Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.com_group_name") %>' 
                                Font-Size="X-Small" 
                                ID="cb_compGroup"
                                Width="300" 
                                DropDownWidth="300px"
                                AutoPostBack="false" 
                                OnItemsRequested="cb_compGroup_ItemsRequested" 
                                OnSelectedIndexChanged="cb_compGroup_SelectedIndexChanged" 
                                OnPreRender="cb_compGroup_PreRender" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Comp. " CssClass="lbObject" ></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="cb_comp" ForeColor="Red" 
                            Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.com_name") %>' 
                                Font-Size="X-Small"
                                ID="cb_comp" 
                                Width="300"
                                DropDownWidth="300px"
                                AutoPostBack="false"
                                OnItemsRequested="cb_comp_ItemsRequested"
                                OnSelectedIndexChanged="cb_comp_SelectedIndexChanged"
                                OnPreRender="cb_comp_PreRender" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Diagnosis " CssClass="lbObject" ></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_diagnosis" ForeColor="Red" 
                            Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.diag_remark") %>' 
                                Font-Size="X-Small" 
                                ID="cb_diagnosis" 
                                Width="300" 
                                DropDownWidth="300px"
                                AutoPostBack="false"
                                OnItemsRequested="cb_diagnosis_ItemsRequested" 
                                OnSelectedIndexChanged="cb_diagnosis_SelectedIndexChanged" 
                                OnPreRender="cb_diagnosis_PreRender" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Symptom " CssClass="lbObject"></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_symptom" ForeColor="Red" 
                            Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td>
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.sym_name") %>' 
                                Font-Size="X-Small"
                                ID="cb_symptom" 
                                Width="300" DropDownWidth="300px"
                                AutoPostBack="false"
                                OnItemsRequested="cb_symptom_ItemsRequested"
                                OnSelectedIndexChanged="cb_symptom_SelectedIndexChanged"
                                OnPreRender="cb_symptom_PreRender">
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Job Description " CssClass="lbObject" ></telerik:RadLabel>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txt_jobDesc" ForeColor="Red" 
                            Font-Size="X-Small" Text="required!"></asp:RequiredFieldValidator><br />
                        </td>
                        <td style="width:320px">
                            <telerik:RadTextBox ID="txt_jobDesc" runat="server" TextMode="MultiLine" Font-Size="X-Small" Width="300px" Rows="0" TabIndex="5" Resize="Both"
                                Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' >
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>           
            </td>
            <td >
                <table id="Table4" border="0" class="module">
                    <%--<tr>
                        <td colspan="2" style="padding:0px 0px 4px 0px">
                            <telerik:RadLabel runat="server" Text="Status" Font-Size="Small" Font-Bold="true" Font-Underline="true" ForeColor="deepskyblue"></telerik:RadLabel>
                        </td>
                    </tr>--%>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="Unit Status " CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td style="vertical-align:top; text-align:left">
                            <%--<asp:UpdatePanel runat="server">
                                <ContentTemplate>--%>
                                    <asp:CheckBox ID="chk_breakdown" runat="server" AutoPostBack="true" Text="Breakdown" Font-Size="12px"  CausesValidation="false"
                                    OnCheckedChanged="chk_breakdown_CheckedChanged" Checked='<%# DataBinder.Eval(Container, "DataItem.tDown") %>' OnPreRender="chk_breakdown_PreRender"  />
                                <%--</ContentTemplate>
                            </asp:UpdatePanel>       --%>                                 
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <telerik:RadLabel runat="server" Text="BD Date" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td style="vertical-align:top; text-align:left">
                            <%-- <asp:UpdatePanel runat="server">
                                <ContentTemplate>--%>
                                    <telerik:RadDatePicker ID="dtp_breakdownDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.BDDate") %>' Enabled="false"
                                        TabIndex="4" Skin="Telerik" > 
                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                        <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                        </DateInput>
                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                    </telerik:RadDatePicker> 
                                    &nbsp                          
                                    <telerik:RadTimePicker ID="rtp_breakdownTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"
                                       Enabled="false" DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.breakdown_time") %>'></telerik:RadTimePicker> 
                            <%--</ContentTemplate>
                                 <Triggers>
                                     <asp:AsyncPostBackTrigger ControlID="chk_breakdown" />
                                 </Triggers>
                            </asp:UpdatePanel>     --%>                                        
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Exc. Start Date" CssClass="lbObject"></telerik:RadLabel>
                        </td>                
                        <td style="vertical-align:top; text-align:left">
                            <telerik:RadDatePicker ID="dtp_excStartDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.compstdate") %>'
                                TabIndex="4" Skin="Telerik" > 
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                            </telerik:RadDatePicker> 
                            &nbsp
                          
                            <telerik:RadTimePicker ID="rtp_excStartTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"                                
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ext_start_time") %>'></telerik:RadTimePicker>   
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadLabel runat="server" Text="Exc. Finish Date" CssClass="lbObject"></telerik:RadLabel>
                        </td>                
                        <td style="vertical-align:top; text-align:left">
                            <telerik:RadDatePicker ID="dtp_excFinishDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Lightweight"                                
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.compfndate") %>'
                                TabIndex="4" Skin="Telerik" > 
                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" 
                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" Skin="Telerik"></Calendar>
                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                <EmptyMessageStyle Resize="Both"></EmptyMessageStyle>
                                </DateInput>
                                <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                            </telerik:RadDatePicker>  
                            &nbsp
                            <telerik:RadTimePicker ID="rtp_excFinishTime" runat="server" RenderMode="Lightweight" Width="80px" AutoPostBack="false"                               
                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ext_fnish_time") %>'></telerik:RadTimePicker>            
                        </td>
                    </tr>                   
                    <tr>
                        <td class="tdLabel">
                            <telerik:RadLabel runat="server" Text="Maint. Type" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td style="vertical-align:top; text-align:left">
                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Telerik" 
                                CausesValidation="false" HighlightTemplatedItems="true" MarkFirstMatch="true" EnableVirtualScrolling="true"
                                Text='<%# DataBinder.Eval(Container, "DataItem.maintType") %>'
                                ID="cb_mainType" 
                                Width="250px"                                       
                                OnSelectedIndexChanged="cb_mainType_SelectedIndexChanged"
                                OnItemsRequested="cb_mainType_ItemsRequested" 
                                OnPreRender="cb_mainType_PreRender">
                            </telerik:RadComboBox>                       
                        </td>

                    </tr>
                    
                </table>
            </td>
        </tr>    
                   
    </table>
</div>
 <telerik:RadWindowManager RenderMode="Lightweight" ID="RadWindowManager1" runat="server" EnableShadow="true">
</telerik:RadWindowManager>