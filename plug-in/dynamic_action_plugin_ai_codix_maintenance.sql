prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.3'
,p_default_workspace_id=>50493436446232566405
,p_default_application_id=>268417
,p_default_id_offset=>0
,p_default_owner=>'WKSP_CODIX'
);
end;
/
 
prompt APPLICATION 268417 - Under Maintenance
--
-- Application Export:
--   Application:     268417
--   Name:            Under Maintenance
--   Date and Time:   02:45 Friday September 1, 2023
--   Exported By:     CODIX.LLC@GMAIL.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 58962334241089425565
--   Manifest End
--   Version:         23.1.3
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/ai_codix_maintenance
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(58962334241089425565)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'AI.CODIX.MAINTENANCE'
,p_display_name=>'Application Under Maintenance'
,p_category=>'NAVIGATION'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'------------------------------------------------------------------------------',
'-- function get_js_function',
'------------------------------------------------------------------------------',
'function get_js_function(p_is_active in varchar2) return varchar2',
'',
'is',
'',
'  l_js  varchar2(4000);',
'',
'begin',
'   IF p_is_active = ''Y'' THEN',
'    l_js := ''function() { console.log("Application Under Maintenance ...") }'';',
'   ELSE ',
'     l_js := ''function() {  }'';',
'   END IF;',
'  return l_js;',
'  ',
'end get_js_function;',
'',
'',
'',
'------------------------------------------------------------------------------',
'-- function render',
'------------------------------------------------------------------------------',
'function render(',
'    p_dynamic_action in apex_plugin.t_dynamic_action',
'    ,p_plugin         in apex_plugin.t_plugin )',
'    return apex_plugin.t_dynamic_action_render_result',
'is',
'      l_redirect_url VARCHAR2(4000);',
'      l_url                             VARCHAR2(200) ;',
'      l_mintance_page_number            apex_application_page_items.attribute_01%type := p_dynamic_action.attribute_01; ',
'      l_is_active                       apex_application_page_items.attribute_02%type := p_dynamic_action.attribute_02; ',
'      l_result                          apex_plugin.t_dynamic_action_render_result;',
'begin',
'     IF l_is_active = ''Y'' THEN ',
'     l_url := ''f?p=''||:APP_ID||'':''||l_mintance_page_number||'':''||:APP_SESSION||'':::::'';',
'     IF :APP_PAGE_ID  NOT IN (l_mintance_page_number) AND NV(''APP_BUILDER_SESSION'') IS  NULL THEN',
'        /* Set the Under Maintenance URL to redirect once process is active */',
'        l_redirect_url := APEX_UTIL.PREPARE_URL(',
'                            p_url => l_url',
'                          );',
'       /* -- Perform the redirect */',
'       APEX_UTIL.REDIRECT_URL(p_url => l_redirect_url);',
'    END IF;',
'    END IF;',
'    l_result.javascript_function := get_js_function(p_is_active => l_is_active);',
'   ',
'    return l_result;',
'end render;'))
,p_default_escape_mode=>'HTML'
,p_api_version=>2
,p_render_function=>'render'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://codix.ai/'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(58962224694530674524)
,p_plugin_id=>wwv_flow_imp.id(58962334241089425565)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Maintenance Page'
,p_attribute_type=>'PAGE NUMBER'
,p_is_required=>true
,p_is_translatable=>false
,p_help_text=>'Select Maintenance Page and make sure it''s public'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(58962513346404683024)
,p_plugin_id=>wwv_flow_imp.id(58962334241089425565)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Activate Maintenance Mode'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
,p_help_text=>'if Yes then Maintenance Mode will be activated.'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
