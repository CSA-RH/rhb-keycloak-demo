--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8 (Debian 15.8-1.pgdg120+1)
-- Dumped by pg_dump version 15.8 (Debian 15.8-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO testuser;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO testuser;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO testuser;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO testuser;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO testuser;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO testuser;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO testuser;

--
-- Name: client; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO testuser;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO testuser;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO testuser;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO testuser;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO testuser;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO testuser;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO testuser;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO testuser;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO testuser;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO testuser;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO testuser;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO testuser;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO testuser;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO testuser;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO testuser;

--
-- Name: component; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO testuser;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO testuser;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO testuser;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO testuser;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO testuser;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO testuser;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO testuser;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO testuser;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO testuser;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO testuser;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO testuser;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO testuser;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO testuser;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO testuser;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO testuser;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO testuser;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO testuser;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO testuser;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO testuser;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO testuser;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO testuser;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO testuser;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO testuser;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO testuser;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO testuser;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO testuser;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO testuser;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO testuser;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO testuser;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO testuser;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO testuser;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO testuser;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO testuser;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO testuser;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO testuser;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO testuser;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO testuser;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO testuser;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO testuser;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO testuser;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO testuser;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO testuser;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO testuser;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO testuser;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO testuser;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO testuser;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO testuser;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO testuser;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO testuser;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO testuser;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO testuser;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO testuser;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO testuser;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO testuser;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO testuser;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO testuser;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO testuser;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO testuser;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO testuser;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO testuser;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO testuser;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO testuser;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO testuser;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO testuser;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO testuser;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO testuser;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO testuser;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO testuser;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO testuser;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: testuser
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO testuser;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
4daf7065-60a8-49b1-8508-e96309f1e767	\N	auth-cookie	527fc094-fada-4190-a49a-737d201c5c4c	565cdcb1-96fb-47be-b894-cbf762038273	2	10	f	\N	\N
f93ec7ad-6692-411c-9df4-6324062f36ab	\N	auth-spnego	527fc094-fada-4190-a49a-737d201c5c4c	565cdcb1-96fb-47be-b894-cbf762038273	3	20	f	\N	\N
4d076bea-4a8b-41ca-a02e-20272348a3b4	\N	identity-provider-redirector	527fc094-fada-4190-a49a-737d201c5c4c	565cdcb1-96fb-47be-b894-cbf762038273	2	25	f	\N	\N
32bf03cc-883b-4167-8c23-b30d948f8f76	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	565cdcb1-96fb-47be-b894-cbf762038273	2	30	t	27b55c2a-ad6c-4b25-bef1-beb3bb4b5756	\N
66b58582-7c0b-4fca-b241-5d022bc8117b	\N	auth-username-password-form	527fc094-fada-4190-a49a-737d201c5c4c	27b55c2a-ad6c-4b25-bef1-beb3bb4b5756	0	10	f	\N	\N
99baa2bd-5e25-484e-8bb2-77abe77f333c	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	27b55c2a-ad6c-4b25-bef1-beb3bb4b5756	1	20	t	31047009-c7a0-454d-a34e-86537941e45f	\N
7d5829e5-f974-4c40-804b-b4be846517d3	\N	conditional-user-configured	527fc094-fada-4190-a49a-737d201c5c4c	31047009-c7a0-454d-a34e-86537941e45f	0	10	f	\N	\N
c193707b-9e94-44b5-aba0-1d3155d47859	\N	auth-otp-form	527fc094-fada-4190-a49a-737d201c5c4c	31047009-c7a0-454d-a34e-86537941e45f	0	20	f	\N	\N
335e883b-32fa-4d8f-a7f2-b40077d33435	\N	direct-grant-validate-username	527fc094-fada-4190-a49a-737d201c5c4c	f06dffd0-5e72-4db8-a229-439821c68d31	0	10	f	\N	\N
cb8f47c9-dbf6-43cd-9c18-513b6fb1542f	\N	direct-grant-validate-password	527fc094-fada-4190-a49a-737d201c5c4c	f06dffd0-5e72-4db8-a229-439821c68d31	0	20	f	\N	\N
8a695333-adf3-4647-ab9f-faf473356557	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	f06dffd0-5e72-4db8-a229-439821c68d31	1	30	t	563459ad-6c51-4ffb-9e9b-9e0ca50cfc46	\N
42b31f0d-f556-4a94-bf35-e2837443072c	\N	conditional-user-configured	527fc094-fada-4190-a49a-737d201c5c4c	563459ad-6c51-4ffb-9e9b-9e0ca50cfc46	0	10	f	\N	\N
0d623f28-414a-4607-a82d-fa9390a8b524	\N	direct-grant-validate-otp	527fc094-fada-4190-a49a-737d201c5c4c	563459ad-6c51-4ffb-9e9b-9e0ca50cfc46	0	20	f	\N	\N
fb491e08-42cb-4ef9-9188-47b7eedb23b5	\N	registration-page-form	527fc094-fada-4190-a49a-737d201c5c4c	b0e36e45-e2ae-4946-8a58-97087b22ccf6	0	10	t	f67796ab-b536-46ad-9cfd-78d26a310f8c	\N
60aea328-049b-4da9-aa02-5b7d2bafa7af	\N	registration-user-creation	527fc094-fada-4190-a49a-737d201c5c4c	f67796ab-b536-46ad-9cfd-78d26a310f8c	0	20	f	\N	\N
eab12d9c-1b64-4037-9a98-4ef024d4397e	\N	registration-password-action	527fc094-fada-4190-a49a-737d201c5c4c	f67796ab-b536-46ad-9cfd-78d26a310f8c	0	50	f	\N	\N
d3d1f212-8174-458c-b833-c69134971b03	\N	registration-recaptcha-action	527fc094-fada-4190-a49a-737d201c5c4c	f67796ab-b536-46ad-9cfd-78d26a310f8c	3	60	f	\N	\N
4d457ef5-db0f-4fc1-8c03-3bd9629da946	\N	registration-terms-and-conditions	527fc094-fada-4190-a49a-737d201c5c4c	f67796ab-b536-46ad-9cfd-78d26a310f8c	3	70	f	\N	\N
c67c49d9-f8b0-42cf-a82c-a4994ee35b6f	\N	reset-credentials-choose-user	527fc094-fada-4190-a49a-737d201c5c4c	52c9a07b-f9a7-4f47-9bd7-a302725439bc	0	10	f	\N	\N
3cc6fb0d-218c-4c27-8824-0ae9749772d1	\N	reset-credential-email	527fc094-fada-4190-a49a-737d201c5c4c	52c9a07b-f9a7-4f47-9bd7-a302725439bc	0	20	f	\N	\N
d94bce2f-af90-493c-b698-7a49cfaaf6af	\N	reset-password	527fc094-fada-4190-a49a-737d201c5c4c	52c9a07b-f9a7-4f47-9bd7-a302725439bc	0	30	f	\N	\N
4830e055-8f92-4e11-ac10-dce79fded378	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	52c9a07b-f9a7-4f47-9bd7-a302725439bc	1	40	t	f9995aaa-703b-4c94-90ad-380b196a6511	\N
53292cd0-656c-4393-8546-0681bbf8add3	\N	conditional-user-configured	527fc094-fada-4190-a49a-737d201c5c4c	f9995aaa-703b-4c94-90ad-380b196a6511	0	10	f	\N	\N
0bd6c3c2-ecaa-4850-98bd-ff9af8e8fe7b	\N	reset-otp	527fc094-fada-4190-a49a-737d201c5c4c	f9995aaa-703b-4c94-90ad-380b196a6511	0	20	f	\N	\N
97db4d4e-57da-487d-a6a7-cf01b582c808	\N	client-secret	527fc094-fada-4190-a49a-737d201c5c4c	c37ac211-e332-497e-a32d-32422c4f536f	2	10	f	\N	\N
647aad64-0776-4c5b-abbb-2b2b9c33a9e1	\N	client-jwt	527fc094-fada-4190-a49a-737d201c5c4c	c37ac211-e332-497e-a32d-32422c4f536f	2	20	f	\N	\N
4459459b-d322-4650-9425-80af6342377f	\N	client-secret-jwt	527fc094-fada-4190-a49a-737d201c5c4c	c37ac211-e332-497e-a32d-32422c4f536f	2	30	f	\N	\N
503febb8-0087-4bd8-9d24-891702cf94b6	\N	client-x509	527fc094-fada-4190-a49a-737d201c5c4c	c37ac211-e332-497e-a32d-32422c4f536f	2	40	f	\N	\N
43238b4c-2edd-4a2f-8cd4-ebb981517c8a	\N	idp-review-profile	527fc094-fada-4190-a49a-737d201c5c4c	a59d3638-49f5-4569-8814-395fb27e930b	0	10	f	\N	c1395620-6dfb-4b62-8a83-d7366b543319
899e7192-6aa7-46d4-8fc9-9cfa094a6236	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	a59d3638-49f5-4569-8814-395fb27e930b	0	20	t	7feaaac3-13b6-48d3-9113-87dc833e7fa4	\N
1e2348bb-3665-47eb-821a-4b27404a2217	\N	idp-create-user-if-unique	527fc094-fada-4190-a49a-737d201c5c4c	7feaaac3-13b6-48d3-9113-87dc833e7fa4	2	10	f	\N	6defa4a2-0e6c-4d8f-8b32-7a31b204e2f1
f85b12d1-3314-4614-af37-7f494ed13410	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	7feaaac3-13b6-48d3-9113-87dc833e7fa4	2	20	t	ec5b4562-ae79-4754-8141-09449bce550f	\N
7f5dbf09-53d0-4990-b837-ee20f0179412	\N	idp-confirm-link	527fc094-fada-4190-a49a-737d201c5c4c	ec5b4562-ae79-4754-8141-09449bce550f	0	10	f	\N	\N
b6e42847-ba14-4e68-8dda-70c7c1e504a3	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	ec5b4562-ae79-4754-8141-09449bce550f	0	20	t	bf63f16f-157f-47e1-807e-e5c29dc8c379	\N
bb715e79-137e-4b18-8e68-9613570540da	\N	idp-email-verification	527fc094-fada-4190-a49a-737d201c5c4c	bf63f16f-157f-47e1-807e-e5c29dc8c379	2	10	f	\N	\N
c7a9820d-b4b5-4a43-896b-8be09d846f30	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	bf63f16f-157f-47e1-807e-e5c29dc8c379	2	20	t	224c7b07-b24a-40e1-bffe-10cfe8077975	\N
257b8f4f-fc37-4ddb-acd0-e350712a4a57	\N	idp-username-password-form	527fc094-fada-4190-a49a-737d201c5c4c	224c7b07-b24a-40e1-bffe-10cfe8077975	0	10	f	\N	\N
8b4c04ba-33c3-4295-b805-3da98600fcde	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	224c7b07-b24a-40e1-bffe-10cfe8077975	1	20	t	38489e4a-f94b-475f-93df-d3a60fc0b874	\N
a782d04a-9de7-4d4d-aa26-21b3939b3afd	\N	conditional-user-configured	527fc094-fada-4190-a49a-737d201c5c4c	38489e4a-f94b-475f-93df-d3a60fc0b874	0	10	f	\N	\N
d3e94a9f-fe3a-4c8e-ae82-37a1ee763a21	\N	auth-otp-form	527fc094-fada-4190-a49a-737d201c5c4c	38489e4a-f94b-475f-93df-d3a60fc0b874	0	20	f	\N	\N
abc77e09-e6aa-4c1e-9909-a65050b1cccd	\N	http-basic-authenticator	527fc094-fada-4190-a49a-737d201c5c4c	783abe7e-12b7-4ec3-b26a-ca82c084a9be	0	10	f	\N	\N
e0f8e4fd-4c9e-4424-a847-614960698d6a	\N	docker-http-basic-authenticator	527fc094-fada-4190-a49a-737d201c5c4c	5cd9347b-daab-43ad-a533-17c4bc536bd2	0	10	f	\N	\N
2689f021-2e79-40b5-9d87-d01bf89820b0	\N	idp-email-verification	e214324c-91eb-4614-b756-7470275d6389	36271420-466d-46bd-a721-3047e779591f	2	10	f	\N	\N
67ea5a4b-4ace-4325-a566-f633f109d722	\N	\N	e214324c-91eb-4614-b756-7470275d6389	36271420-466d-46bd-a721-3047e779591f	2	20	t	bf0d1be8-2c48-477b-87d8-04399362b789	\N
9463ba94-29ea-4ca2-b57c-92f400e171df	\N	conditional-user-configured	e214324c-91eb-4614-b756-7470275d6389	7e1f7c98-58f6-4b50-8489-8e87609158f3	0	10	f	\N	\N
c5f91c5f-4c33-49fb-893b-b6c3de2756e5	\N	auth-otp-form	e214324c-91eb-4614-b756-7470275d6389	7e1f7c98-58f6-4b50-8489-8e87609158f3	0	20	f	\N	\N
87b5144a-7188-4c38-8807-8739d52111d2	\N	conditional-user-configured	e214324c-91eb-4614-b756-7470275d6389	f76107b2-5b2a-46d7-8ed7-9255d11166b6	0	10	f	\N	\N
54fc2c6a-eb9d-4ccf-841f-bf9279b09894	\N	direct-grant-validate-otp	e214324c-91eb-4614-b756-7470275d6389	f76107b2-5b2a-46d7-8ed7-9255d11166b6	0	20	f	\N	\N
f6c9296f-e94a-4ddf-8b75-5b56c7dc4798	\N	conditional-user-configured	e214324c-91eb-4614-b756-7470275d6389	76bfb444-f950-45b9-a4b5-469810b74245	0	10	f	\N	\N
f1108c85-b3ec-4145-9149-246c09a4fb64	\N	auth-otp-form	e214324c-91eb-4614-b756-7470275d6389	76bfb444-f950-45b9-a4b5-469810b74245	0	20	f	\N	\N
c9f89fc2-b4fb-4945-9fd2-1cd2442ea649	\N	idp-confirm-link	e214324c-91eb-4614-b756-7470275d6389	600c306b-c126-4a6b-9581-e3886f12a50a	0	10	f	\N	\N
68fef3df-2906-4cf0-bf33-568ac3b916a2	\N	\N	e214324c-91eb-4614-b756-7470275d6389	600c306b-c126-4a6b-9581-e3886f12a50a	0	20	t	36271420-466d-46bd-a721-3047e779591f	\N
e01cd2cc-71d7-49e8-9c99-ecd314228e2d	\N	conditional-user-configured	e214324c-91eb-4614-b756-7470275d6389	940eda9e-5b95-4706-a08d-7c7e6b499d1f	0	10	f	\N	\N
44522eab-6339-4e38-a6e9-3d3a5f411d19	\N	reset-otp	e214324c-91eb-4614-b756-7470275d6389	940eda9e-5b95-4706-a08d-7c7e6b499d1f	0	20	f	\N	\N
9ffda059-cc8a-411c-8d09-ed4d138f86f2	\N	idp-create-user-if-unique	e214324c-91eb-4614-b756-7470275d6389	1f4f73ad-4f9d-478e-9c5a-cb66c740c094	2	10	f	\N	20801798-a099-42ef-b8f6-09a63c838f30
285d4636-8138-4d75-a9f9-ffe8902d8dbc	\N	\N	e214324c-91eb-4614-b756-7470275d6389	1f4f73ad-4f9d-478e-9c5a-cb66c740c094	2	20	t	600c306b-c126-4a6b-9581-e3886f12a50a	\N
dd15bb19-f044-40e4-99e0-b5813cde0b0c	\N	idp-username-password-form	e214324c-91eb-4614-b756-7470275d6389	bf0d1be8-2c48-477b-87d8-04399362b789	0	10	f	\N	\N
d2d73fbc-1b5f-47d9-bcf7-462d705f44a2	\N	\N	e214324c-91eb-4614-b756-7470275d6389	bf0d1be8-2c48-477b-87d8-04399362b789	1	20	t	76bfb444-f950-45b9-a4b5-469810b74245	\N
2c7b0919-0de6-4e55-9f00-cbb5ea7a91c2	\N	auth-cookie	e214324c-91eb-4614-b756-7470275d6389	2f5f7e64-11b2-4008-9255-f34d2f740ba9	2	10	f	\N	\N
664defd0-aacd-45bb-8596-270b807370bc	\N	auth-spnego	e214324c-91eb-4614-b756-7470275d6389	2f5f7e64-11b2-4008-9255-f34d2f740ba9	3	20	f	\N	\N
41bd6375-4b2e-4b56-a513-f10bfaa3ba6e	\N	identity-provider-redirector	e214324c-91eb-4614-b756-7470275d6389	2f5f7e64-11b2-4008-9255-f34d2f740ba9	2	25	f	\N	\N
c9e3d941-07ff-4377-8350-9f5c3f14cfda	\N	\N	e214324c-91eb-4614-b756-7470275d6389	2f5f7e64-11b2-4008-9255-f34d2f740ba9	2	30	t	ee9f3087-46b1-493a-bf76-daed4966596c	\N
736ce435-c0cb-4afe-831d-15a74e31cdb5	\N	client-secret	e214324c-91eb-4614-b756-7470275d6389	eeb7342c-b28d-4724-bc7a-1813f2339aa5	2	10	f	\N	\N
5158ada0-d86b-4d58-a85e-77465285d314	\N	client-jwt	e214324c-91eb-4614-b756-7470275d6389	eeb7342c-b28d-4724-bc7a-1813f2339aa5	2	20	f	\N	\N
d4a5c345-b530-4f0a-9c85-35f842d704c3	\N	client-secret-jwt	e214324c-91eb-4614-b756-7470275d6389	eeb7342c-b28d-4724-bc7a-1813f2339aa5	2	30	f	\N	\N
23ae9399-d0d6-4db2-94d5-a7b522ee1d1c	\N	client-x509	e214324c-91eb-4614-b756-7470275d6389	eeb7342c-b28d-4724-bc7a-1813f2339aa5	2	40	f	\N	\N
40f84954-111e-4a50-afc3-e2899ee8feb1	\N	direct-grant-validate-username	e214324c-91eb-4614-b756-7470275d6389	12eb524e-b3e9-4e00-af69-d34c5ec8f73b	0	10	f	\N	\N
17e9c4ca-be0d-4c56-8a0f-249b61933a99	\N	direct-grant-validate-password	e214324c-91eb-4614-b756-7470275d6389	12eb524e-b3e9-4e00-af69-d34c5ec8f73b	0	20	f	\N	\N
066c74dd-d403-4900-bfb7-54d3629cfbd2	\N	\N	e214324c-91eb-4614-b756-7470275d6389	12eb524e-b3e9-4e00-af69-d34c5ec8f73b	1	30	t	f76107b2-5b2a-46d7-8ed7-9255d11166b6	\N
9dcb047c-dd15-44bb-815e-3578f49458a3	\N	docker-http-basic-authenticator	e214324c-91eb-4614-b756-7470275d6389	3de0b057-b9a7-4d6e-bcc1-a9e870eb6c15	0	10	f	\N	\N
2c28fab2-e9cb-4080-90f0-24f5978b1e64	\N	idp-review-profile	e214324c-91eb-4614-b756-7470275d6389	316e5e1a-a8cd-41d0-9142-1c72332eced3	0	10	f	\N	cb578860-f5d0-4f32-ae88-544d00460574
879885c4-d169-4674-abf2-a9acb19a7d3e	\N	\N	e214324c-91eb-4614-b756-7470275d6389	316e5e1a-a8cd-41d0-9142-1c72332eced3	0	20	t	1f4f73ad-4f9d-478e-9c5a-cb66c740c094	\N
c3052a71-9a2b-4dd1-8176-4048542a2839	\N	auth-username-password-form	e214324c-91eb-4614-b756-7470275d6389	ee9f3087-46b1-493a-bf76-daed4966596c	0	10	f	\N	\N
b82007dd-2c16-4f45-a870-6c83456ffe5b	\N	\N	e214324c-91eb-4614-b756-7470275d6389	ee9f3087-46b1-493a-bf76-daed4966596c	1	20	t	7e1f7c98-58f6-4b50-8489-8e87609158f3	\N
0e3c81a7-a70b-4c62-8fc2-577983249ac9	\N	registration-page-form	e214324c-91eb-4614-b756-7470275d6389	7b249fc6-fd70-4bbb-8bb5-829a1c97a9e2	0	10	t	fa7b67c4-29d8-411c-bfeb-824bbb398e4f	\N
28b66f86-44b8-43e8-addd-413495cebd78	\N	registration-user-creation	e214324c-91eb-4614-b756-7470275d6389	fa7b67c4-29d8-411c-bfeb-824bbb398e4f	0	20	f	\N	\N
8d9c69c9-2a51-458a-9db8-e1e154347acb	\N	registration-password-action	e214324c-91eb-4614-b756-7470275d6389	fa7b67c4-29d8-411c-bfeb-824bbb398e4f	0	50	f	\N	\N
f76c4af7-2f85-42d8-b0ff-7cc405c1bdb4	\N	registration-recaptcha-action	e214324c-91eb-4614-b756-7470275d6389	fa7b67c4-29d8-411c-bfeb-824bbb398e4f	3	60	f	\N	\N
10a163b9-d949-4493-8141-02732b1d4b3f	\N	registration-terms-and-conditions	e214324c-91eb-4614-b756-7470275d6389	fa7b67c4-29d8-411c-bfeb-824bbb398e4f	3	70	f	\N	\N
57f34d1f-c9e9-486c-b5c0-2ea7c62f3a80	\N	reset-credentials-choose-user	e214324c-91eb-4614-b756-7470275d6389	3d98a1f5-3683-4668-81fa-bbff95917f14	0	10	f	\N	\N
bb958e59-bb3c-47aa-a2cb-ff60c810e6c3	\N	reset-credential-email	e214324c-91eb-4614-b756-7470275d6389	3d98a1f5-3683-4668-81fa-bbff95917f14	0	20	f	\N	\N
570fa533-8ca7-409c-b714-9b00215cf271	\N	reset-password	e214324c-91eb-4614-b756-7470275d6389	3d98a1f5-3683-4668-81fa-bbff95917f14	0	30	f	\N	\N
da16edf3-313d-469d-bd5c-58328745f798	\N	\N	e214324c-91eb-4614-b756-7470275d6389	3d98a1f5-3683-4668-81fa-bbff95917f14	1	40	t	940eda9e-5b95-4706-a08d-7c7e6b499d1f	\N
0e5e4ec6-a675-4abe-9eb9-be343f1e6034	\N	http-basic-authenticator	e214324c-91eb-4614-b756-7470275d6389	1913f075-b478-4d85-a8bc-79b7a8c190dd	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
565cdcb1-96fb-47be-b894-cbf762038273	browser	browser based authentication	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
27b55c2a-ad6c-4b25-bef1-beb3bb4b5756	forms	Username, password, otp and other auth forms.	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
31047009-c7a0-454d-a34e-86537941e45f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
f06dffd0-5e72-4db8-a229-439821c68d31	direct grant	OpenID Connect Resource Owner Grant	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
563459ad-6c51-4ffb-9e9b-9e0ca50cfc46	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
b0e36e45-e2ae-4946-8a58-97087b22ccf6	registration	registration flow	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
f67796ab-b536-46ad-9cfd-78d26a310f8c	registration form	registration form	527fc094-fada-4190-a49a-737d201c5c4c	form-flow	f	t
52c9a07b-f9a7-4f47-9bd7-a302725439bc	reset credentials	Reset credentials for a user if they forgot their password or something	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
f9995aaa-703b-4c94-90ad-380b196a6511	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
c37ac211-e332-497e-a32d-32422c4f536f	clients	Base authentication for clients	527fc094-fada-4190-a49a-737d201c5c4c	client-flow	t	t
a59d3638-49f5-4569-8814-395fb27e930b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
7feaaac3-13b6-48d3-9113-87dc833e7fa4	User creation or linking	Flow for the existing/non-existing user alternatives	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
ec5b4562-ae79-4754-8141-09449bce550f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
bf63f16f-157f-47e1-807e-e5c29dc8c379	Account verification options	Method with which to verity the existing account	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
224c7b07-b24a-40e1-bffe-10cfe8077975	Verify Existing Account by Re-authentication	Reauthentication of existing account	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
38489e4a-f94b-475f-93df-d3a60fc0b874	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	f	t
783abe7e-12b7-4ec3-b26a-ca82c084a9be	saml ecp	SAML ECP Profile Authentication Flow	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
5cd9347b-daab-43ad-a533-17c4bc536bd2	docker auth	Used by Docker clients to authenticate against the IDP	527fc094-fada-4190-a49a-737d201c5c4c	basic-flow	t	t
36271420-466d-46bd-a721-3047e779591f	Account verification options	Method with which to verity the existing account	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
7e1f7c98-58f6-4b50-8489-8e87609158f3	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
f76107b2-5b2a-46d7-8ed7-9255d11166b6	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
76bfb444-f950-45b9-a4b5-469810b74245	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
600c306b-c126-4a6b-9581-e3886f12a50a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
940eda9e-5b95-4706-a08d-7c7e6b499d1f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
1f4f73ad-4f9d-478e-9c5a-cb66c740c094	User creation or linking	Flow for the existing/non-existing user alternatives	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
bf0d1be8-2c48-477b-87d8-04399362b789	Verify Existing Account by Re-authentication	Reauthentication of existing account	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
2f5f7e64-11b2-4008-9255-f34d2f740ba9	browser	browser based authentication	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
eeb7342c-b28d-4724-bc7a-1813f2339aa5	clients	Base authentication for clients	e214324c-91eb-4614-b756-7470275d6389	client-flow	t	t
12eb524e-b3e9-4e00-af69-d34c5ec8f73b	direct grant	OpenID Connect Resource Owner Grant	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
3de0b057-b9a7-4d6e-bcc1-a9e870eb6c15	docker auth	Used by Docker clients to authenticate against the IDP	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
316e5e1a-a8cd-41d0-9142-1c72332eced3	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
ee9f3087-46b1-493a-bf76-daed4966596c	forms	Username, password, otp and other auth forms.	e214324c-91eb-4614-b756-7470275d6389	basic-flow	f	t
7b249fc6-fd70-4bbb-8bb5-829a1c97a9e2	registration	registration flow	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
fa7b67c4-29d8-411c-bfeb-824bbb398e4f	registration form	registration form	e214324c-91eb-4614-b756-7470275d6389	form-flow	f	t
3d98a1f5-3683-4668-81fa-bbff95917f14	reset credentials	Reset credentials for a user if they forgot their password or something	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
1913f075-b478-4d85-a8bc-79b7a8c190dd	saml ecp	SAML ECP Profile Authentication Flow	e214324c-91eb-4614-b756-7470275d6389	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
c1395620-6dfb-4b62-8a83-d7366b543319	review profile config	527fc094-fada-4190-a49a-737d201c5c4c
6defa4a2-0e6c-4d8f-8b32-7a31b204e2f1	create unique user config	527fc094-fada-4190-a49a-737d201c5c4c
20801798-a099-42ef-b8f6-09a63c838f30	create unique user config	e214324c-91eb-4614-b756-7470275d6389
cb578860-f5d0-4f32-ae88-544d00460574	review profile config	e214324c-91eb-4614-b756-7470275d6389
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
6defa4a2-0e6c-4d8f-8b32-7a31b204e2f1	false	require.password.update.after.registration
c1395620-6dfb-4b62-8a83-d7366b543319	missing	update.profile.on.first.login
20801798-a099-42ef-b8f6-09a63c838f30	false	require.password.update.after.registration
cb578860-f5d0-4f32-ae88-544d00460574	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d845197a-8f81-4129-ba71-08d654fc8706	t	f	master-realm	0	f	\N	\N	t	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3c3eab9f-45df-4b5f-bf9d-b33371593045	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f566a3c8-ba06-473d-9761-0d69de489bc3	t	f	broker	0	f	\N	\N	t	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8152e404-de3a-4404-a139-aa7feb9dba14	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e142ec1f-d516-4533-9e12-ed3e100818c8	t	f	csa-realm	0	f	\N	\N	t	\N	f	527fc094-fada-4190-a49a-737d201c5c4c	\N	0	f	f	csa Realm	f	client-secret	\N	\N	\N	t	f	f	f
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	t	f	account	0	t	\N	/realms/csa/account/	f	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	t	f	account-console	0	t	\N	/realms/csa/account/	f	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
96c93424-5d33-4137-987e-fbd44492209f	t	f	admin-cli	0	t	\N	\N	f	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
47d99075-b88b-4dfb-b55a-096f10748956	t	f	broker	0	f	\N	\N	t	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	f	realm-management	0	f	\N	\N	t	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	t	f	security-admin-console	0	t	\N	/admin/csa/console/	f	\N	f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
1d401474-10ce-4b15-b372-2884e64a3da2	t	t	webauth	0	t	\N		f		f	e214324c-91eb-4614-b756-7470275d6389	openid-connect	-1	t	f	Web Authentication	f	client-secret			\N	t	f	t	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	t	f	admin-cli	0	f	QPAkRRLgHkSqmJs3i38myKgDD2NV6woc		f		f	527fc094-fada-4190-a49a-737d201c5c4c	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	f	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	post.logout.redirect.uris	+
3c3eab9f-45df-4b5f-bf9d-b33371593045	post.logout.redirect.uris	+
3c3eab9f-45df-4b5f-bf9d-b33371593045	pkce.code.challenge.method	S256
8152e404-de3a-4404-a139-aa7feb9dba14	post.logout.redirect.uris	+
8152e404-de3a-4404-a139-aa7feb9dba14	pkce.code.challenge.method	S256
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	post.logout.redirect.uris	+
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	pkce.code.challenge.method	S256
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	post.logout.redirect.uris	+
96c93424-5d33-4137-987e-fbd44492209f	post.logout.redirect.uris	+
47d99075-b88b-4dfb-b55a-096f10748956	post.logout.redirect.uris	+
81ec4301-bb48-4be1-b1b2-f39d729b51a0	post.logout.redirect.uris	+
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	pkce.code.challenge.method	S256
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	post.logout.redirect.uris	+
1d401474-10ce-4b15-b372-2884e64a3da2	backchannel.logout.revoke.offline.tokens	false
1d401474-10ce-4b15-b372-2884e64a3da2	backchannel.logout.session.required	true
1d401474-10ce-4b15-b372-2884e64a3da2	display.on.consent.screen	false
1d401474-10ce-4b15-b372-2884e64a3da2	oauth2.device.authorization.grant.enabled	false
1d401474-10ce-4b15-b372-2884e64a3da2	oidc.ciba.grant.enabled	false
1d401474-10ce-4b15-b372-2884e64a3da2	post.logout.redirect.uris	*
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	oauth2.device.authorization.grant.enabled	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	oidc.ciba.grant.enabled	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	display.on.consent.screen	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	backchannel.logout.session.required	true
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	backchannel.logout.revoke.offline.tokens	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	use.refresh.tokens	true
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	client_credentials.use_refresh_token	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	token.response.type.bearer.lower-case	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	tls.client.certificate.bound.access.tokens	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	require.pushed.authorization.requests	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	client.use.lightweight.access.token.enabled	false
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	acr.loa.map	{}
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	client.secret.creation.time	1724777671
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
6614952e-03a5-481d-9dc1-6afe746e551c	offline_access	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect built-in scope: offline_access	openid-connect
07eefa70-939b-4081-bf48-0eef48b02db4	role_list	527fc094-fada-4190-a49a-737d201c5c4c	SAML role list	saml
f3da7958-fe87-4152-a66a-0268033f287f	profile	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect built-in scope: profile	openid-connect
38a21469-2bf2-48c7-b294-b690ecc5ae0f	email	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect built-in scope: email	openid-connect
40c5df01-4571-4c08-8ff0-a7a75e04e592	address	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect built-in scope: address	openid-connect
63a01feb-58de-40ad-b3e2-965a66043d9d	phone	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect built-in scope: phone	openid-connect
414e1893-0da7-4950-9081-302b335d09eb	roles	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect scope for add user roles to the access token	openid-connect
0653ab45-7b02-44b5-abcb-0aafb5875f32	web-origins	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect scope for add allowed web origins to the access token	openid-connect
6294c724-64dc-4c44-838c-6380897b8c0e	microprofile-jwt	527fc094-fada-4190-a49a-737d201c5c4c	Microprofile - JWT built-in scope	openid-connect
216460d6-cf71-4a35-88f7-5b334d1a25c5	acr	527fc094-fada-4190-a49a-737d201c5c4c	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
dd8c9029-1969-46e9-b098-83cdbce76e86	role_list	e214324c-91eb-4614-b756-7470275d6389	SAML role list	saml
001064ca-bf3a-4b1b-94de-40e0fc817d1d	roles	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect scope for add user roles to the access token	openid-connect
6387d083-9198-4f81-9f96-55d60b84e9b9	address	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect built-in scope: address	openid-connect
1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	offline_access	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect built-in scope: offline_access	openid-connect
dd35585d-392c-42b1-b43e-2729c10fe338	phone	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect built-in scope: phone	openid-connect
e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	web-origins	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3fc192f8-eebb-464c-90c1-5a0af885cb80	email	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect built-in scope: email	openid-connect
36071bb1-2e70-47fd-a7d1-927d06c02ce6	microprofile-jwt	e214324c-91eb-4614-b756-7470275d6389	Microprofile - JWT built-in scope	openid-connect
1451242f-55d5-4eeb-877d-038c96080dfd	acr	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
12ba1413-0920-478f-80d7-0e34b8c8fecc	profile	e214324c-91eb-4614-b756-7470275d6389	OpenID Connect built-in scope: profile	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
6614952e-03a5-481d-9dc1-6afe746e551c	true	display.on.consent.screen
6614952e-03a5-481d-9dc1-6afe746e551c	${offlineAccessScopeConsentText}	consent.screen.text
07eefa70-939b-4081-bf48-0eef48b02db4	true	display.on.consent.screen
07eefa70-939b-4081-bf48-0eef48b02db4	${samlRoleListScopeConsentText}	consent.screen.text
f3da7958-fe87-4152-a66a-0268033f287f	true	display.on.consent.screen
f3da7958-fe87-4152-a66a-0268033f287f	${profileScopeConsentText}	consent.screen.text
f3da7958-fe87-4152-a66a-0268033f287f	true	include.in.token.scope
38a21469-2bf2-48c7-b294-b690ecc5ae0f	true	display.on.consent.screen
38a21469-2bf2-48c7-b294-b690ecc5ae0f	${emailScopeConsentText}	consent.screen.text
38a21469-2bf2-48c7-b294-b690ecc5ae0f	true	include.in.token.scope
40c5df01-4571-4c08-8ff0-a7a75e04e592	true	display.on.consent.screen
40c5df01-4571-4c08-8ff0-a7a75e04e592	${addressScopeConsentText}	consent.screen.text
40c5df01-4571-4c08-8ff0-a7a75e04e592	true	include.in.token.scope
63a01feb-58de-40ad-b3e2-965a66043d9d	true	display.on.consent.screen
63a01feb-58de-40ad-b3e2-965a66043d9d	${phoneScopeConsentText}	consent.screen.text
63a01feb-58de-40ad-b3e2-965a66043d9d	true	include.in.token.scope
414e1893-0da7-4950-9081-302b335d09eb	true	display.on.consent.screen
414e1893-0da7-4950-9081-302b335d09eb	${rolesScopeConsentText}	consent.screen.text
414e1893-0da7-4950-9081-302b335d09eb	false	include.in.token.scope
0653ab45-7b02-44b5-abcb-0aafb5875f32	false	display.on.consent.screen
0653ab45-7b02-44b5-abcb-0aafb5875f32		consent.screen.text
0653ab45-7b02-44b5-abcb-0aafb5875f32	false	include.in.token.scope
6294c724-64dc-4c44-838c-6380897b8c0e	false	display.on.consent.screen
6294c724-64dc-4c44-838c-6380897b8c0e	true	include.in.token.scope
216460d6-cf71-4a35-88f7-5b334d1a25c5	false	display.on.consent.screen
216460d6-cf71-4a35-88f7-5b334d1a25c5	false	include.in.token.scope
dd8c9029-1969-46e9-b098-83cdbce76e86	${samlRoleListScopeConsentText}	consent.screen.text
dd8c9029-1969-46e9-b098-83cdbce76e86	true	display.on.consent.screen
001064ca-bf3a-4b1b-94de-40e0fc817d1d	${rolesScopeConsentText}	consent.screen.text
001064ca-bf3a-4b1b-94de-40e0fc817d1d	true	display.on.consent.screen
001064ca-bf3a-4b1b-94de-40e0fc817d1d	false	include.in.token.scope
6387d083-9198-4f81-9f96-55d60b84e9b9	${addressScopeConsentText}	consent.screen.text
6387d083-9198-4f81-9f96-55d60b84e9b9	true	display.on.consent.screen
6387d083-9198-4f81-9f96-55d60b84e9b9	true	include.in.token.scope
1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	${offlineAccessScopeConsentText}	consent.screen.text
1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	true	display.on.consent.screen
dd35585d-392c-42b1-b43e-2729c10fe338	${phoneScopeConsentText}	consent.screen.text
dd35585d-392c-42b1-b43e-2729c10fe338	true	display.on.consent.screen
dd35585d-392c-42b1-b43e-2729c10fe338	true	include.in.token.scope
e8049765-52d1-4c6f-8ecb-1cf5510f1f5d		consent.screen.text
e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	false	display.on.consent.screen
e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	false	include.in.token.scope
3fc192f8-eebb-464c-90c1-5a0af885cb80	${emailScopeConsentText}	consent.screen.text
3fc192f8-eebb-464c-90c1-5a0af885cb80	true	display.on.consent.screen
3fc192f8-eebb-464c-90c1-5a0af885cb80	true	include.in.token.scope
36071bb1-2e70-47fd-a7d1-927d06c02ce6	false	display.on.consent.screen
36071bb1-2e70-47fd-a7d1-927d06c02ce6	true	include.in.token.scope
1451242f-55d5-4eeb-877d-038c96080dfd	false	display.on.consent.screen
1451242f-55d5-4eeb-877d-038c96080dfd	false	include.in.token.scope
12ba1413-0920-478f-80d7-0e34b8c8fecc	${profileScopeConsentText}	consent.screen.text
12ba1413-0920-478f-80d7-0e34b8c8fecc	true	display.on.consent.screen
12ba1413-0920-478f-80d7-0e34b8c8fecc	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	414e1893-0da7-4950-9081-302b335d09eb	t
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	f3da7958-fe87-4152-a66a-0268033f287f	t
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	6294c724-64dc-4c44-838c-6380897b8c0e	f
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	63a01feb-58de-40ad-b3e2-965a66043d9d	f
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	6614952e-03a5-481d-9dc1-6afe746e551c	f
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
3c3eab9f-45df-4b5f-bf9d-b33371593045	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
3c3eab9f-45df-4b5f-bf9d-b33371593045	414e1893-0da7-4950-9081-302b335d09eb	t
3c3eab9f-45df-4b5f-bf9d-b33371593045	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
3c3eab9f-45df-4b5f-bf9d-b33371593045	f3da7958-fe87-4152-a66a-0268033f287f	t
3c3eab9f-45df-4b5f-bf9d-b33371593045	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
3c3eab9f-45df-4b5f-bf9d-b33371593045	6294c724-64dc-4c44-838c-6380897b8c0e	f
3c3eab9f-45df-4b5f-bf9d-b33371593045	63a01feb-58de-40ad-b3e2-965a66043d9d	f
3c3eab9f-45df-4b5f-bf9d-b33371593045	6614952e-03a5-481d-9dc1-6afe746e551c	f
3c3eab9f-45df-4b5f-bf9d-b33371593045	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	414e1893-0da7-4950-9081-302b335d09eb	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	f3da7958-fe87-4152-a66a-0268033f287f	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	6294c724-64dc-4c44-838c-6380897b8c0e	f
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	63a01feb-58de-40ad-b3e2-965a66043d9d	f
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	6614952e-03a5-481d-9dc1-6afe746e551c	f
3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
f566a3c8-ba06-473d-9761-0d69de489bc3	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
f566a3c8-ba06-473d-9761-0d69de489bc3	414e1893-0da7-4950-9081-302b335d09eb	t
f566a3c8-ba06-473d-9761-0d69de489bc3	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
f566a3c8-ba06-473d-9761-0d69de489bc3	f3da7958-fe87-4152-a66a-0268033f287f	t
f566a3c8-ba06-473d-9761-0d69de489bc3	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
f566a3c8-ba06-473d-9761-0d69de489bc3	6294c724-64dc-4c44-838c-6380897b8c0e	f
f566a3c8-ba06-473d-9761-0d69de489bc3	63a01feb-58de-40ad-b3e2-965a66043d9d	f
f566a3c8-ba06-473d-9761-0d69de489bc3	6614952e-03a5-481d-9dc1-6afe746e551c	f
f566a3c8-ba06-473d-9761-0d69de489bc3	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
d845197a-8f81-4129-ba71-08d654fc8706	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
d845197a-8f81-4129-ba71-08d654fc8706	414e1893-0da7-4950-9081-302b335d09eb	t
d845197a-8f81-4129-ba71-08d654fc8706	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
d845197a-8f81-4129-ba71-08d654fc8706	f3da7958-fe87-4152-a66a-0268033f287f	t
d845197a-8f81-4129-ba71-08d654fc8706	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
d845197a-8f81-4129-ba71-08d654fc8706	6294c724-64dc-4c44-838c-6380897b8c0e	f
d845197a-8f81-4129-ba71-08d654fc8706	63a01feb-58de-40ad-b3e2-965a66043d9d	f
d845197a-8f81-4129-ba71-08d654fc8706	6614952e-03a5-481d-9dc1-6afe746e551c	f
d845197a-8f81-4129-ba71-08d654fc8706	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
8152e404-de3a-4404-a139-aa7feb9dba14	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
8152e404-de3a-4404-a139-aa7feb9dba14	414e1893-0da7-4950-9081-302b335d09eb	t
8152e404-de3a-4404-a139-aa7feb9dba14	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
8152e404-de3a-4404-a139-aa7feb9dba14	f3da7958-fe87-4152-a66a-0268033f287f	t
8152e404-de3a-4404-a139-aa7feb9dba14	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
8152e404-de3a-4404-a139-aa7feb9dba14	6294c724-64dc-4c44-838c-6380897b8c0e	f
8152e404-de3a-4404-a139-aa7feb9dba14	63a01feb-58de-40ad-b3e2-965a66043d9d	f
8152e404-de3a-4404-a139-aa7feb9dba14	6614952e-03a5-481d-9dc1-6afe746e551c	f
8152e404-de3a-4404-a139-aa7feb9dba14	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	1451242f-55d5-4eeb-877d-038c96080dfd	t
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	6387d083-9198-4f81-9f96-55d60b84e9b9	f
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	dd35585d-392c-42b1-b43e-2729c10fe338	f
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	1451242f-55d5-4eeb-877d-038c96080dfd	t
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	6387d083-9198-4f81-9f96-55d60b84e9b9	f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	dd35585d-392c-42b1-b43e-2729c10fe338	f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
96c93424-5d33-4137-987e-fbd44492209f	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
96c93424-5d33-4137-987e-fbd44492209f	1451242f-55d5-4eeb-877d-038c96080dfd	t
96c93424-5d33-4137-987e-fbd44492209f	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
96c93424-5d33-4137-987e-fbd44492209f	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
96c93424-5d33-4137-987e-fbd44492209f	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
96c93424-5d33-4137-987e-fbd44492209f	6387d083-9198-4f81-9f96-55d60b84e9b9	f
96c93424-5d33-4137-987e-fbd44492209f	dd35585d-392c-42b1-b43e-2729c10fe338	f
96c93424-5d33-4137-987e-fbd44492209f	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
96c93424-5d33-4137-987e-fbd44492209f	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
47d99075-b88b-4dfb-b55a-096f10748956	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
47d99075-b88b-4dfb-b55a-096f10748956	1451242f-55d5-4eeb-877d-038c96080dfd	t
47d99075-b88b-4dfb-b55a-096f10748956	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
47d99075-b88b-4dfb-b55a-096f10748956	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
47d99075-b88b-4dfb-b55a-096f10748956	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
47d99075-b88b-4dfb-b55a-096f10748956	6387d083-9198-4f81-9f96-55d60b84e9b9	f
47d99075-b88b-4dfb-b55a-096f10748956	dd35585d-392c-42b1-b43e-2729c10fe338	f
47d99075-b88b-4dfb-b55a-096f10748956	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
47d99075-b88b-4dfb-b55a-096f10748956	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
81ec4301-bb48-4be1-b1b2-f39d729b51a0	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
81ec4301-bb48-4be1-b1b2-f39d729b51a0	1451242f-55d5-4eeb-877d-038c96080dfd	t
81ec4301-bb48-4be1-b1b2-f39d729b51a0	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
81ec4301-bb48-4be1-b1b2-f39d729b51a0	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
81ec4301-bb48-4be1-b1b2-f39d729b51a0	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
81ec4301-bb48-4be1-b1b2-f39d729b51a0	6387d083-9198-4f81-9f96-55d60b84e9b9	f
81ec4301-bb48-4be1-b1b2-f39d729b51a0	dd35585d-392c-42b1-b43e-2729c10fe338	f
81ec4301-bb48-4be1-b1b2-f39d729b51a0	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
81ec4301-bb48-4be1-b1b2-f39d729b51a0	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	1451242f-55d5-4eeb-877d-038c96080dfd	t
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	6387d083-9198-4f81-9f96-55d60b84e9b9	f
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	dd35585d-392c-42b1-b43e-2729c10fe338	f
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
1d401474-10ce-4b15-b372-2884e64a3da2	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
1d401474-10ce-4b15-b372-2884e64a3da2	1451242f-55d5-4eeb-877d-038c96080dfd	t
1d401474-10ce-4b15-b372-2884e64a3da2	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
1d401474-10ce-4b15-b372-2884e64a3da2	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
1d401474-10ce-4b15-b372-2884e64a3da2	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
1d401474-10ce-4b15-b372-2884e64a3da2	6387d083-9198-4f81-9f96-55d60b84e9b9	f
1d401474-10ce-4b15-b372-2884e64a3da2	dd35585d-392c-42b1-b43e-2729c10fe338	f
1d401474-10ce-4b15-b372-2884e64a3da2	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
1d401474-10ce-4b15-b372-2884e64a3da2	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
6614952e-03a5-481d-9dc1-6afe746e551c	bb0fbd2a-a9ea-491a-bb07-43077c69a75f
1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	a053142b-ded5-4d2e-b00f-7e4fbe0c74c8
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
2a37641a-3b31-4e59-9e20-192dcd21184c	Trusted Hosts	527fc094-fada-4190-a49a-737d201c5c4c	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
53bff687-4604-4b13-9f8a-07ed98c02f0b	Consent Required	527fc094-fada-4190-a49a-737d201c5c4c	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
37c7f2ba-45e5-4ced-909b-526756867e42	Full Scope Disabled	527fc094-fada-4190-a49a-737d201c5c4c	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
a7e68571-dfd1-47b0-9454-67a6de4c72ff	Max Clients Limit	527fc094-fada-4190-a49a-737d201c5c4c	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
404a6a26-e2b2-431b-acc4-3336e0788e81	Allowed Protocol Mapper Types	527fc094-fada-4190-a49a-737d201c5c4c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
962f5bdb-0b53-4af8-a8da-d825901a2346	Allowed Client Scopes	527fc094-fada-4190-a49a-737d201c5c4c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	anonymous
1aee52ca-cd79-4fde-8d71-62d4b7b4e233	Allowed Protocol Mapper Types	527fc094-fada-4190-a49a-737d201c5c4c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	authenticated
feeef628-63ca-4227-8862-620f88447a35	Allowed Client Scopes	527fc094-fada-4190-a49a-737d201c5c4c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	527fc094-fada-4190-a49a-737d201c5c4c	authenticated
39eb4686-7263-4b23-ae98-cfe52ed7edd8	rsa-generated	527fc094-fada-4190-a49a-737d201c5c4c	rsa-generated	org.keycloak.keys.KeyProvider	527fc094-fada-4190-a49a-737d201c5c4c	\N
0ba55be4-e2bf-4160-ace6-e1433cbeed98	rsa-enc-generated	527fc094-fada-4190-a49a-737d201c5c4c	rsa-enc-generated	org.keycloak.keys.KeyProvider	527fc094-fada-4190-a49a-737d201c5c4c	\N
b6c6aa46-49f5-4812-b4c6-7f068726b749	hmac-generated-hs512	527fc094-fada-4190-a49a-737d201c5c4c	hmac-generated	org.keycloak.keys.KeyProvider	527fc094-fada-4190-a49a-737d201c5c4c	\N
3e376814-f2a6-4052-9f70-b5e1dfd4ea4b	aes-generated	527fc094-fada-4190-a49a-737d201c5c4c	aes-generated	org.keycloak.keys.KeyProvider	527fc094-fada-4190-a49a-737d201c5c4c	\N
371264b9-7bd6-4c9d-9147-1734682d9fee	\N	527fc094-fada-4190-a49a-737d201c5c4c	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	527fc094-fada-4190-a49a-737d201c5c4c	\N
5b22a38e-df47-4986-bd66-98192a3ba5a5	Consent Required	e214324c-91eb-4614-b756-7470275d6389	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
57f6fd36-4a09-488a-b33f-e905cb373768	Full Scope Disabled	e214324c-91eb-4614-b756-7470275d6389	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
e10e9017-b65d-4a01-89a6-96a4f3de1881	Max Clients Limit	e214324c-91eb-4614-b756-7470275d6389	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
ce541537-3c26-4e47-b2e5-03df40b7bc4c	Allowed Client Scopes	e214324c-91eb-4614-b756-7470275d6389	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	authenticated
e5c16696-86a7-4287-af4a-82e85751cc8c	Allowed Protocol Mapper Types	e214324c-91eb-4614-b756-7470275d6389	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
7cccb4d7-651b-439b-b6f0-1f4d62dfad54	Allowed Client Scopes	e214324c-91eb-4614-b756-7470275d6389	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
900e934e-4f29-468d-b55b-f059b319cf37	Allowed Protocol Mapper Types	e214324c-91eb-4614-b756-7470275d6389	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	authenticated
aba2637e-2013-40c9-995b-49b1f40da983	Trusted Hosts	e214324c-91eb-4614-b756-7470275d6389	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e214324c-91eb-4614-b756-7470275d6389	anonymous
eefb54a2-cf14-47ee-8101-a13d2da39559	hmac-generated-hs512	e214324c-91eb-4614-b756-7470275d6389	hmac-generated	org.keycloak.keys.KeyProvider	e214324c-91eb-4614-b756-7470275d6389	\N
70ee256d-72e5-4da6-81d3-3037eec5cfbb	rsa-enc-generated	e214324c-91eb-4614-b756-7470275d6389	rsa-enc-generated	org.keycloak.keys.KeyProvider	e214324c-91eb-4614-b756-7470275d6389	\N
c75e7f02-2f40-4e8b-b2b9-db02f2b63850	rsa-generated	e214324c-91eb-4614-b756-7470275d6389	rsa-generated	org.keycloak.keys.KeyProvider	e214324c-91eb-4614-b756-7470275d6389	\N
55d01067-a99d-4e1c-83db-cfc61f442ccf	aes-generated	e214324c-91eb-4614-b756-7470275d6389	aes-generated	org.keycloak.keys.KeyProvider	e214324c-91eb-4614-b756-7470275d6389	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
2a4911cc-5776-4a1e-8d56-41cbdb986630	962f5bdb-0b53-4af8-a8da-d825901a2346	allow-default-scopes	true
311bafa8-cfe3-4b4d-9a65-434c69ca5738	2a37641a-3b31-4e59-9e20-192dcd21184c	host-sending-registration-request-must-match	true
c8075319-d309-424a-9375-86dd6b5a3a76	2a37641a-3b31-4e59-9e20-192dcd21184c	client-uris-must-match	true
6daa98c5-aadd-41ff-9155-28d07e862c09	feeef628-63ca-4227-8862-620f88447a35	allow-default-scopes	true
d9f4a984-5ebc-499f-a470-fd742af77b7e	a7e68571-dfd1-47b0-9454-67a6de4c72ff	max-clients	200
1832075f-b298-490f-8ee2-2a6e55dda369	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	saml-user-attribute-mapper
253d779b-a80a-429d-a90e-a5c73173266b	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
4547c0e8-7ff2-4729-a65a-bc6050a2a345	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	saml-user-property-mapper
214bc4b3-b936-43eb-81e7-253cc28f3d86	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	oidc-address-mapper
84e721f0-0683-469d-9889-c45ced5c1140	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0e48d373-feec-4484-8bfc-fb34048f3d4a	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	oidc-full-name-mapper
a0d07c87-44c7-4fd5-aa90-8daafcc2e3cd	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a1c9c3d1-ec58-4c04-a67f-7a9ed54d41c9	1aee52ca-cd79-4fde-8d71-62d4b7b4e233	allowed-protocol-mapper-types	saml-role-list-mapper
61a8165a-81ca-4535-af36-3ca8d6590318	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	saml-user-attribute-mapper
dd5153af-9fc2-4091-963e-03f26658de10	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	oidc-full-name-mapper
d4d63879-dd21-45f9-8512-5f595b39ab06	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4dd659d8-ed4e-4539-ae24-8a323bc08b6f	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	saml-user-property-mapper
50bfd8b2-1b89-41e7-84c8-900b6f999140	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	oidc-address-mapper
d2fe8f48-a63c-48af-a9f7-a77567758ef3	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6330690f-804a-4c68-8a82-4279706fff90	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3aee8e26-5f28-4e9c-a6c0-d0a80f4bc740	404a6a26-e2b2-431b-acc4-3336e0788e81	allowed-protocol-mapper-types	saml-role-list-mapper
eb09efd9-3a1e-4d49-8857-5c6be1bf115e	371264b9-7bd6-4c9d-9147-1734682d9fee	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
574c4283-dc56-47ac-84e9-d56a1d016afd	0ba55be4-e2bf-4160-ace6-e1433cbeed98	algorithm	RSA-OAEP
b86d9fcb-518c-4fa2-9b5f-749c8504e56f	0ba55be4-e2bf-4160-ace6-e1433cbeed98	keyUse	ENC
a1b1ab36-7a4f-4721-9925-7041bf041cc1	0ba55be4-e2bf-4160-ace6-e1433cbeed98	certificate	MIICmzCCAYMCBgGRdCMSmzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwODIxMDg1MDQxWhcNMzQwODIxMDg1MjIxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC34rWTrlJ5rSame16i0d7w+HSotRaAwpIPJOeGpVDGUoImKPpcKqGdmXpsUkMET+3TznzwgPXf2Z8sgAHBwYQevRV+37AE70dW0ZHphbvAWR8w03hNeUs/nj8QymxlchMY4zvgVdScPSMqqMat5A+WquCWYYE2wlPdW+hUssEk1jL5pO+U7tgwbmDmHdX3+sBIaMnV0SAp5KjnZguU1hTZpkqWgYVPCefEG+Lj/NL6sVEPTvESMy7EcRNpov/4bm7Ny0ZttefQ9+a4tmqIIYuXFPZRKcaICBQ3CcMi4BcGGyd6sXTXcuG7wniE9KeDems5Ud7YKHA4WiCSF4M/xCSZAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKds0UIvN1JH1nnaVNE+EDcveJf1ydT+inD3ULiMKbFAdHBGjKETDawgH3Y3jFmgX1sg/XrI81meJundU1V7jBKQZPpB1KwN9A3a+CqGWZzsg/Q+aGDhtp/LXaJ23BgitXut6uSVee/BTBFF/43lWHu8W+wIeSawUhJGgkut45A+a1czsfLl7coEICKq4OYRseYKmmrap7+v1ph9AuZeY18NMFhW8nwJ3DZoltuiBut5GnBf/PGAnB3IksZF6jcEyjt//r85avVREvVERusIa5GqXI/ZZ4LLlfVzqxDFqhf/KldlEVfQrjOst1msRr8zNi08tXqrru/fT9g4BpSQ9yM=
f723bab2-a6f6-4e02-974b-c465cf4b6d7b	0ba55be4-e2bf-4160-ace6-e1433cbeed98	priority	100
8dfcbbef-8509-42cb-a0b7-289f751e44d2	0ba55be4-e2bf-4160-ace6-e1433cbeed98	privateKey	MIIEogIBAAKCAQEAt+K1k65Sea0mpnteotHe8Ph0qLUWgMKSDyTnhqVQxlKCJij6XCqhnZl6bFJDBE/t08588ID139mfLIABwcGEHr0Vft+wBO9HVtGR6YW7wFkfMNN4TXlLP54/EMpsZXITGOM74FXUnD0jKqjGreQPlqrglmGBNsJT3VvoVLLBJNYy+aTvlO7YMG5g5h3V9/rASGjJ1dEgKeSo52YLlNYU2aZKloGFTwnnxBvi4/zS+rFRD07xEjMuxHETaaL/+G5uzctGbbXn0PfmuLZqiCGLlxT2USnGiAgUNwnDIuAXBhsnerF013Lhu8J4hPSng3prOVHe2ChwOFogkheDP8QkmQIDAQABAoIBAASOxpYeWx43sdZsxqHVvpc9q0OOuHvwxqbAMQpj8NJ3k1D/kUQFTPvvZMrIR6+0zPXj33IlGiMGHXVAh3qeUahi4qRiRjY7GYsv9tRBS6/m7Zhb13ahH+G36gOAJutlRk6mvDJRYkuMkuFw7Tq8ZTwEaHxltoqNSr+Y8nNd+l5Ps5KXEADoh3kwuo1h9D1ZT9vvNb4hTGbDz5o8V/WTBRmpvPUzlvXpq8yG/qpguIX0E4+R8Dsbw8IcPBYpwTnEAmgZ6R8TnrcrX40ay88TeQIeXh7mS0IULp4778t0fQTrijsu8FDsK/86WydPmGjZucjLbpAvnv8q+OKNhXpRseECgYEA2TJW4qo5Kkg29hm1rdp9b6oEmRbVG42oQcpYV1NgxuetqxWhatkDOnhkxfGSPpCGP7LzmtEiz7JEKrssIV2s1nawik7H/M7YJzXPzcfQh/6rO/aVbFj5XqjBXQtVK2j8wo6o3twPOOvyCM5a2/sZglqfFlOWivPKIYU/Ju9KtmECgYEA2Lzcwuix9HoU+6JYu2wuswUsqv1E3PvdeGIIBP+u/2SDGB2ZppX/eQpD79WnF/uEmf7rnGDcOiI7YIMmS3uIxe2UzLXK3YH2V/PYOa5TU0lliJbVz1HWURl+Rf+LANNDrpWGNk1Dj7DFSQQetv6JbkY6AYfKlS6A5dme2hBsKTkCgYB2jxH6fKzjtbO6tuIDWqbqE0abQmlltvfHoeqDEJJdQQ39u7r3Fiq6+gkYO/t2h3Ggx9BODCcSdN7c7Hr0Y6v7DaLkfIiSKV64WJlsXMwp0AwsmTeLgy3sS/XxEkSVg6OlmDX6IOl2SuU9hVb3iaOtEkaQ62PbyaPmlFOarzh7QQKBgBekenx0f70IeDN+4SkIwwtaPCYm3JUykFUqdG9/KKrJXxeJWxJ1+FlOylxmNQUDtdJKoY78bemVhF6hz9KaFjBpGzs9dXS2UZYEjoi0QHisX/wHYCluZu+P1VtzZclgQljQDMTtproM8Whmn6ccmwdBd+Bk3K9rVDo+g/qLohDZAoGAJ4J/3KfCLYtDtb4yIv1YBETaI6qas5r3kYnz+aRO2jwmNfmUwOdWnWdq2WnG7TJeeM8WyJtQXdyblcbhEQ9pQPg+7ZOF6QT8G957i2sJpSHgNUbmKnKDno5/uqpMmopX4LRdNLv/wxcXkBMxbYoV+iyg/+mnfhbCV06EwgPF1+w=
c61d6a7c-57f3-4885-b530-9ee8ab209aec	39eb4686-7263-4b23-ae98-cfe52ed7edd8	priority	100
e4d29ded-5d45-4e4a-97ad-5a4c1c44e714	39eb4686-7263-4b23-ae98-cfe52ed7edd8	privateKey	MIIEowIBAAKCAQEAmV22W9ygGqthxExi3lRwX7KaGhK7n/IAEYGKhLYPqK/U6szKV008k5E1dKn1LFYmemuWLSOvx9fZi2JWpchBfjz6motfqNjxzUwWJL/r5/wxTk/LAWCDa3L49r9LTL3UakN0aSddtVtW7uWg7lh+f+lG7x5hIqIMrplcad5/gntUDl6eBkK2ZcKrAPLiSs4GC5SEEfNoEMOhxsz67XxFNZlk/yWiHxc+ZKz4PKL0XlBVx0Cukd/6zHBfrMIdFnV7DPUjFDDt28osVHsy4R5XgESNkAZOOzZhlz96MOrONQwWt4daKFlnHgU7modLFQyXotxiLHJ00qTp0UzQG8sUcQIDAQABAoIBAAd57mymYeLeI+zCN7ehSiRM72VoY5K1sccosRLGUhd/d6B5ANjzDPCGQNYOsVyXi1ZAbf7sh6Jbi8e9sLE+nkkdhxUgyJyeJshC3N/hwAniqcyotLuJpus5nMvHVRzI/25GtFZ3JgK0EMk7xg9lOC8OgisgW5l1z0R1Rj03xknoAdmNgXuLJt5pBxYr6JAlkXIW+0uz+1TEYFjhO9PEShTAudmyflfMzIs7p7tttKb8GX8jQZuucAjvQe6+LwpJye2bj4WwnTeGNV6xsxKoDwNwdzNDgngPHy4fKrwP45ydzk1aRY6oaVtPJxoQxPd89zVNKWGOyx++eJOKLMOeTdkCgYEA0FqgtjgX3fA0Tm+Em8G/m+GhPVjSByaTlX4oG2PYT0ewhBPb/+GS+XqOjilFM2hEB8KHVe7nVglW3f8ksT+RolgTq5xEQXok5lCK7DoFbRo/TnmvjqSUs+Pi9UzkgdfgDD19RTwqvEU+ElcwOd6S77PPAJyijVL0xO7+HxJxQAMCgYEAvHAA1+tpgaIVsZoyiSKbef4yb6GAdVYIyoIlokUixVncTEJ5Sr8j1DeCNhizKoR1lt6ulMFaXHBVcEYcAybLJikkfkJrLKSNYxxGzaCpDFmP2j20vxwxfjpeeEKHPOgJSXZfG2s1C2j4tnuqeu6WeqekhB7QhdM3WJ1+12tgcXsCgYEAsPtaqo4pT9+7PqkhtoC0dwAIy6iH94UANisMfH+qfWWC/h40cT22b+536zAJVSqLJyBJf2hI319dh4M0Ms+xsHoqc0pw/EF52J2v9AsxEsUJ42ogAwWwPsIjxoSDUfwCl8MfhtEd6ADVQhUHpRB4Nd7Bxl5HAc7mleYAvHoY8usCgYB0ek8rKGr5JHWAaK4gMnIkgEow0oWTAfFBLB2TJmUN1DPmN5i96VR+Uyl7wtzMxT/iWBdWAAaY6R8G3W9nS017cycJnIie+cAjqVDivhKAfcP7xPS6xPSa7/2BHK53qX5EGJVFX4lUWjiSo/KHNn9xpbp9qIaAkkS90+yZv9fHjQKBgBnBKPJtUTqUCFkWn3haVnIopYiRjta4gqmuSbY4utWttoUsHMcmt0nAq6DN+kM4UYEGo3FOmJ3URNMBTKpFniUOytby41uKJOAVt7P4KbpOOfxFPbwnng/t09lwaiiTQx4AZQx43/+5LDnZLaVd1/tI9BQhFBZcRXIYfzXo7fI4
92a891c8-a0cf-4dbc-8322-47a48c373c12	39eb4686-7263-4b23-ae98-cfe52ed7edd8	keyUse	SIG
34fb4601-b680-4ee1-bbd2-5484d751c502	39eb4686-7263-4b23-ae98-cfe52ed7edd8	certificate	MIICmzCCAYMCBgGRdCMRiDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwODIxMDg1MDQxWhcNMzQwODIxMDg1MjIxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZXbZb3KAaq2HETGLeVHBfspoaEruf8gARgYqEtg+or9TqzMpXTTyTkTV0qfUsViZ6a5YtI6/H19mLYlalyEF+PPqai1+o2PHNTBYkv+vn/DFOT8sBYINrcvj2v0tMvdRqQ3RpJ121W1bu5aDuWH5/6UbvHmEiogyumVxp3n+Ce1QOXp4GQrZlwqsA8uJKzgYLlIQR82gQw6HGzPrtfEU1mWT/JaIfFz5krPg8ovReUFXHQK6R3/rMcF+swh0WdXsM9SMUMO3byixUezLhHleARI2QBk47NmGXP3ow6s41DBa3h1ooWWceBTuah0sVDJei3GIscnTSpOnRTNAbyxRxAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFeIKVGFOrQJYfcJqmPEuKn19oKszmSUBpW8+3w3BE67igJYTLK9aS15Vp1ABG/xJ8c4uyyknoEZg9h48kzu+GRrBF2+2tEusXX/v7C96WCMuuWl3OyEWa7eAIEyyYJjt28IzxE5heuzpri/9zCQ2PgUjUx2gqKR6j1bfrPI6ab9maD/EQj8EFWVoG4Y1llZrTrB4pKIUrk8ArvtwziX5SAmQ1KBK2JE1grCSFPXGMCJO+bAFXDSC4Rzz0EA2I5yqx4wxGCptoihajzboW6vjCsi5KietlcNJ8nEVs+uIoIrz9W8iOif5P7xyWhon6KXRseLdgIOH+TqJj7hXiq0SBE=
c58cf51e-aeea-4103-8fdd-65ead9baa945	b6c6aa46-49f5-4812-b4c6-7f068726b749	secret	BfrVVlLEpmpadYrcCjESZMQovsD9uobRO9Sj9wvE47olB0pfN2-ZuFPCNhV4VOjhr_ctytoHpUuj8d4ZaCbwm9aD7cG6LDMo_aeroQupawYgM2PeAYl6yG_h66LBteZLlQR9VY_-1kRUyDIsjxctSRLbnMoBQ6C9MMow4i3khFE
020949cb-316c-40c8-84f0-e5b8613c4375	b6c6aa46-49f5-4812-b4c6-7f068726b749	priority	100
be0df109-a31f-419f-bf8e-0b0fa6a188e1	b6c6aa46-49f5-4812-b4c6-7f068726b749	kid	bb543bc9-8f84-44b4-b01d-885940258d0e
262056bc-8898-4159-9deb-1b48e13bf3ef	b6c6aa46-49f5-4812-b4c6-7f068726b749	algorithm	HS512
e8afeb62-fa4d-4d95-831b-50bb5baeba61	3e376814-f2a6-4052-9f70-b5e1dfd4ea4b	secret	1elZx5-MqodQFqlfZzVjag
c4977aa2-5ee9-4335-bf9f-caa2e608b2fe	3e376814-f2a6-4052-9f70-b5e1dfd4ea4b	kid	024270f9-1cc6-43d2-bf76-bff5e794aab1
eacd62ac-411b-49bb-9781-01e0ba56f739	3e376814-f2a6-4052-9f70-b5e1dfd4ea4b	priority	100
94fd16e7-d56f-424a-bfce-45afe6ba9c57	eefb54a2-cf14-47ee-8101-a13d2da39559	kid	055595f9-aac1-47b4-a8c1-6d91114570fc
527af70c-ded6-4349-b77e-5f2c5cbafe91	eefb54a2-cf14-47ee-8101-a13d2da39559	algorithm	HS512
c0b5542b-ae93-4130-b95c-0bfc82f127cf	eefb54a2-cf14-47ee-8101-a13d2da39559	priority	100
4cd85462-b953-4733-af07-bcd8428cb95f	eefb54a2-cf14-47ee-8101-a13d2da39559	secret	bvBNT-pfivE_Frpp6BNPBfR0dhHQohMpG2077z5U8CO_W4tPwx8peIAuaNMUDWDnkURHSulgqc2TDcI2bwCIWdzG4yGGMv7Mrz_SheFZSwIZgDP4c-xc8WvFGLGhccS9G9d6xjUeM9HhDAiRGRLLBbMd8hdRevzQcqZfV7oCuVM
73bc4611-c5c0-437f-8726-9fcb40ac0ae9	e10e9017-b65d-4a01-89a6-96a4f3de1881	max-clients	200
5e9309f1-039a-4b0c-bddc-af12d0baca77	ce541537-3c26-4e47-b2e5-03df40b7bc4c	allow-default-scopes	true
b8331b1a-886e-4736-9605-dcd3beb865ec	70ee256d-72e5-4da6-81d3-3037eec5cfbb	certificate	MIIClTCCAX0CBgGRcBntaTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANjc2EwHhcNMjQwODIwMTQwMjEzWhcNMzQwODIwMTQwMzUzWjAOMQwwCgYDVQQDDANjc2EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDWGbBGHBOoiCVOm8tpjADhToA0fQ5otakDIy3snJWXMuuGbjkRvgpPTUoisGrJ/Uaja0ArFbB4HP9uyX10dwaZQHPYPcGfUhaSv9cqDm9PzUuvCo+Qk0wKTu9BgsrOWwaZWsm2FYgMSIXv1nqgZ7yxgRd4L5vrbHdTwFe8DgNf2QTqZAf9g/h/h3MoGep4h2tGbpcc7aE+2YsLZ4fKXuxTleAiqF6pNsxWv6But3Zf+2OqJXf/77QUxRokdiGl+ecczm7pKQGNtc6Y9XIKmjf4VDcwm3mjzRykKu4sI8w4ZFs5VV0PRmYe2BH/LhLjBLoYLYrkSnw4rCtSaWpbyVJnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAC4FgKlOvjwukphLSMnDiKQzJSBLm0Fftvh7Yph4Y6MWqR95x+rMMuEkwh/tOSLjzybZXhf/21Xku3KfCRzeq0ggxQliCWq8zbrVnXFooBc7N8A0nr86n503ArAtazYuxGyoDjlMeR6jCJdb1I/FPI+cyqipGD9IuuklflIYhNzy+qq1HUIx2dNN/oO8Nj798YROpP8iYnbL+ucUZ5MTOOT+alozIbED2QilW0vmzOe152DJugwqeNJA24jatQTrnl55bwLteQESyyNrUxuQwcz8gh63BElI7GpXgze2AULOaIt+lZAvRJUUK1WeBNS/BA4EyJpWbycjMhuQtzwBq1o=
4e6644c3-1684-4ed1-88a3-297af037e649	70ee256d-72e5-4da6-81d3-3037eec5cfbb	privateKey	MIIEowIBAAKCAQEA1hmwRhwTqIglTpvLaYwA4U6ANH0OaLWpAyMt7JyVlzLrhm45Eb4KT01KIrBqyf1Go2tAKxWweBz/bsl9dHcGmUBz2D3Bn1IWkr/XKg5vT81LrwqPkJNMCk7vQYLKzlsGmVrJthWIDEiF79Z6oGe8sYEXeC+b62x3U8BXvA4DX9kE6mQH/YP4f4dzKBnqeIdrRm6XHO2hPtmLC2eHyl7sU5XgIqheqTbMVr+gbrd2X/tjqiV3/++0FMUaJHYhpfnnHM5u6SkBjbXOmPVyCpo3+FQ3MJt5o80cpCruLCPMOGRbOVVdD0ZmHtgR/y4S4wS6GC2K5Ep8OKwrUmlqW8lSZwIDAQABAoIBAATZLXmg+CPLlXpLiXzMS7000sidgZG6D2fZSGVAmuiciBXevoWAb4MiBaKpREaeHDCy/ilOz+5TmPs2x+CdZpv0CDHzUBFEdOtoBos9KwsisISRvieKSZRwLiqmUUmaaRjyI+A70GPK0dgMQnGjqvO84yQSTyF/lTVja5LM7gmh4C1mBij0dqmW7wMo32Kdn1B6+motQq4UW1A78jj9QvreGNJRx1ZJDtyfkb8fUHn1shQ8Vl2jHkdlWpjuB9EfeExZvLn9yP8/fBsCPY0dowfTItGi1bGnIzI4WqrzfwEJ1hZBS0+W5BAgeYL7cevi2/cgPm4I6mfk3DbMtOmTN/ECgYEA8WTut2qQ+JSbwlM3m8jr+zSWQucqUsiHWVrExKAfKIjJVLKaf2eHfFz9HzD64x8rljoenE00Rsx9O6bDWA6EalR6hbsv2el1MThkRVc5O+e06y6qDNFExJAA+K09O9gXmWIvOc+FYfTbnombY1QedGc/vIQMMAYPyh/M9+queJECgYEA4w385y7heJ7eRTIexsMHYUlSHIB5jha3y4Fldw3Xg5oJ4sTnjRp11DJDiVC8Lb6H7zCC4cY+fGP15oyhs9BDi+O7K56pjOP5qIWB80AIjj5xVjCKwDVrKqsJZNuN0q1l7+Xq9eK6H+pYoDHXdX2wFSdPjK0d2CQtyqsLK2lWV3cCgYEA3ZAvz6f/gjocsQNiwhlsB7lfxe6ZmTw3hxtaCcOSdcj/Sj9YsWHcKJjNN+jkDr1Ya13TJNF0Dxu4Qp0xJUzF2zbI8qA6LoAqsc+5sS969/IXy9mb+YHG5cfrLFUOJDSWjJFjGWPRYHS3c8+IEWZvQZZXGPf2m8mkingf0NnV5BECgYAUnEdxwNqstVcd1t/eUQPRe/NdLPhbwooqifNo7DO8+XWeRRtzvowll+5zf4WlbV8vgirPTcyMRBKlO+zNwsDu6NwrqHphlKwr9PqH1y8volFtbniZ2/9/Xwk6Q4fLMPxI24kJiuw0S3SCDiQtwRwDv47ECU7lONuDQyV/ak9xHwKBgCmvXxUHQwadXFK0XFEEjhCvkj+VatMhTY6lYOWEsz9D3mFztgwT/QlXkAf4NycHZGS70jdrNs1XzzV2ihNkShSBaqHtt4B7Bb8voIfTeE1cS7L1c45d2gMxB88cLIHAE8hZ26OYe1O5jl55Srg57336JAyyXOfECMwHY8CvnFei
321defe6-210d-42a9-804c-1c227273fc53	70ee256d-72e5-4da6-81d3-3037eec5cfbb	algorithm	RSA-OAEP
c2eade7f-f00f-476d-9388-d8a2ee16911e	70ee256d-72e5-4da6-81d3-3037eec5cfbb	priority	100
c6da80aa-34d6-414e-8981-50a1eb200f73	c75e7f02-2f40-4e8b-b2b9-db02f2b63850	certificate	MIIClTCCAX0CBgGRcBnu4zANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANjc2EwHhcNMjQwODIwMTQwMjEzWhcNMzQwODIwMTQwMzUzWjAOMQwwCgYDVQQDDANjc2EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0mtfi0cd56V3yjSQQZzIeYhfI7MWiX4/Hf2A0/rmPb5bJTRnniCkolkVWJPt1yE5FtEAXCj84PCxF10M/nPXW48GfFpP5oj09FU054+uQ16B7DpKFW3p67pxSgGWXKNjtXGtzueH7LUX4MwEvg8EyW0NZYHob/MEKdvZxRH+Nn9ule4dGgpLi7ZnlqWbjSqyIn51f4YJbejDGuHxDHDsHM53m5XBtolOGkXmIqOchkDZJpiQFiOJQZJ0SBt2fwehsoJMpN4esrnDDEUd4poCWb68ntQe6TyjCmWsF1U4lQCGumSQ/h8i5eRUoXeDQgoTF2eZ2CzhzDokDpZFmOAbPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAD6uSFak4UN5oQcae8iudWfG+m388Xxy2mtVUMAqYImhzXvnSQftJx9c3FFEvY7j316vRDM738zep0qwe9tlkeZ1j93ITxHnjxiXj4xPeDvQ9d8NEqZjs2slmUqPlgzvM1KazAV/W/cE3Dd1hNA5wIcNnrDdOQxch0uUfwXbtwyRWIXSzo/czI1R7Blf7oaOCvS4zGrbdhapolzGCXSOOvTb4al/rHQoSWLPIH6UDwg+XrNsoJJEMiMpqYqaRanYsZizk4KtmMSGM4csIpqEEemLsgP5vItNc/Ugs1NlHNt4YUxb3kJ0Vw+5tNCVyfwyuQ/P6hxbcUFd/2gytA+Vz0=
bf2f6663-f9d4-4f7b-9e12-a0e0ed2f15a6	c75e7f02-2f40-4e8b-b2b9-db02f2b63850	privateKey	MIIEogIBAAKCAQEAtJrX4tHHeeld8o0kEGcyHmIXyOzFol+Px39gNP65j2+WyU0Z54gpKJZFViT7dchORbRAFwo/ODwsRddDP5z11uPBnxaT+aI9PRVNOePrkNegew6ShVt6eu6cUoBllyjY7Vxrc7nh+y1F+DMBL4PBMltDWWB6G/zBCnb2cUR/jZ/bpXuHRoKS4u2Z5alm40qsiJ+dX+GCW3owxrh8Qxw7BzOd5uVwbaJThpF5iKjnIZA2SaYkBYjiUGSdEgbdn8HobKCTKTeHrK5wwxFHeKaAlm+vJ7UHuk8owplrBdVOJUAhrpkkP4fIuXkVKF3g0IKExdnmdgs4cw6JA6WRZjgGzwIDAQABAoIBADEm4xJL3WoEZRkZ6HK+Yxl5wNdh+PeT4mF8/QXvPTkYOYVXgnFM0UbGfuBO+FC5zvORds/Obh4z4iivyRGK+i0dlxhg4KzTxq7VGUtkCDxHMtnKwX2hw9epEMozP3LAHymaOXQpZqMhUyWVXAE+blnyFIZCh3kOdMsQTUnORpiYLyM5W+cFJaVwtGOnUDeLb7EO/6K7Fgyg5IOIEsBjJvatTuz2pQ4tNwgrnreXC9GtSTp69oCb9Ebhorhlniy7X8vsOVdcRk7WRo+NfP1iwOBwXyx17NC4skarugkLECpK7o8ZCCOEDGADUq4DQTYTT6Pry0jHo6zjq0ERpFC1uAECgYEA8kgd9IhvpTF9w73DzhZgMUQwi6LZF4hadjwTwnMBqL4wkhu8iXeItM8508lj+BSi/Z/jgNuFeFMPU64CzB8BF6ElM84QDWXqAlB5/b6Rwl/lEI/SU3CDlhxl8zgYdqaPgxxTZZ+pihCoB9RqvF+Kg0EVOBwYkAiG34/72Hq48wECgYEAvtS3x6u+lKrbr/jEEfTDy/tAnPAIdqfZuiIz4Odiv2J/uMz5c2/H58ggQse9rf4KhGSTfO8SyaeW8WgHpf52kweXiyrY+LXZ4in20FEUBYfC8jsI3WonY5Sar0CpIdLtHpIp2nYgf++cIxFhq+oZvVMADnNllxHz4aXFUVCgic8CgYAqHGzQdvJo1QxV/GLPLEZ16bNCYgC3vWRzzodksdak/MG2c4m2nwcs3iPf8s4kbXnS+XpyiDVPr6gnVER6NB1dfQ3ZTkSt/3vIATLi7r+o+D/5O/ZDuHe2nKL/vk1KOjMRh9fa/wBZ1gFOsxYGPdj2bVaB1ShTyJegvgb5HoONAQKBgGtuV7Q6FMWfVqQ/mSo+sIfCgAKaAznBjwqBvNENkoMKEbtY8coyEMmE2dyelENCtGsKMBnygZIzHf/zv/KMSfbGHGOFkLabsfjoBQIL0wi2AGLcJ0Z3P4uJGng1H8Jh+4ntYVCSlgNQQodffqwI08rI0kxQXM3qlnDfITGBAY/zAoGAf7RpjO/RjCQsCXLewt9A8HLS4aZfsmUCIu0NyOCWbY1oMbTyOm62pva0fVVSODUsY/DDW/+PsxE2ngZM3SPFWLYWcUr5Ac4d0WuFoWz8pqLC43hZgi4+n77IpJmtYSBlQ2Y7IP0EbeYUUFeiw4MuFDlOHZOn458fr8E8giFrZ14=
f08fa1ce-68d9-45a4-88c0-367882e60ff4	c75e7f02-2f40-4e8b-b2b9-db02f2b63850	priority	100
de611664-de40-45d1-a74a-8592226273a2	55d01067-a99d-4e1c-83db-cfc61f442ccf	priority	100
36dbf195-0a0d-4cf6-9785-556c7ec267ee	55d01067-a99d-4e1c-83db-cfc61f442ccf	kid	08945e6f-786c-48f4-9c59-f37c2ec39de3
938f8f1c-64e0-40b0-bb2f-540f4ac3a208	55d01067-a99d-4e1c-83db-cfc61f442ccf	secret	qCkz35oA2IfG-2_5JmGoAQ
4a8340ac-18a5-4078-8903-5a8a45eb7355	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	saml-role-list-mapper
97a12e3a-5cb1-40c1-8f36-ccbc5c00cad2	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	oidc-full-name-mapper
bef1f8d6-ad67-402a-93b8-0b196d8d9415	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	saml-user-attribute-mapper
7cb2f410-66aa-4425-a11d-5410a80d1841	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
83cf4f92-a7a5-402b-b6fe-2ef512ff8c1a	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	saml-user-property-mapper
d7274f31-8327-4167-8c2a-82a4c9e0b203	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	oidc-address-mapper
755457b0-6f7a-44c1-a4fb-c1038048e7c8	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c833fc7-42e8-40ba-bdea-289fcd11a7b7	e5c16696-86a7-4287-af4a-82e85751cc8c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b17a48ec-23b6-4b5a-861b-7de9c6b68054	7cccb4d7-651b-439b-b6f0-1f4d62dfad54	allow-default-scopes	true
b8346bfc-f3a1-48e5-8ba5-a38cbb379f22	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
cc700b85-87c3-4664-b159-564c587252aa	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	saml-user-attribute-mapper
fc8697b9-e07d-4d34-9018-9d791326a4a9	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	oidc-full-name-mapper
1947d318-3e46-4ef8-b279-301ddca3704a	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
72fc81c8-0acd-49fd-b223-6c2f8c4519bf	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	saml-user-property-mapper
6446aac5-5632-49ef-bfe1-21c82c044c2f	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1328f959-9ae7-4bb4-9dc6-d6e5062e47f0	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	oidc-address-mapper
fe78ef3a-ede3-4ae2-a4f9-c888a7c62da4	900e934e-4f29-468d-b55b-f059b319cf37	allowed-protocol-mapper-types	saml-role-list-mapper
f49606d7-4dcc-4998-a9f2-dc87a63cf118	aba2637e-2013-40c9-995b-49b1f40da983	client-uris-must-match	true
c8b546a0-edfc-4583-b463-5d827de06c33	aba2637e-2013-40c9-995b-49b1f40da983	host-sending-registration-request-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.composite_role (composite, child_role) FROM stdin;
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	10819cf3-d54f-48b3-a4d2-5630f4c23e27
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	1e8b1271-66cd-4dae-944b-ec7b967ac449
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	9260374a-a753-4b60-9d1c-3c0e94cb9934
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	3bc85df5-6bc3-4e9e-af2d-395c6acb9a8b
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	3cf414b0-166e-48bc-8a46-0370a8083804
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	e439ce5c-2426-4368-9ca0-97950bac2806
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	bf8b3a61-4e4b-46e7-9833-0b7b01796572
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	377d6a09-36df-46f6-8399-9ab6c3ac053c
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	807bbafb-8eac-4ec0-b35d-3df7f9ee6b6b
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	ad396ebd-8f59-4f7b-92be-3ad606442db7
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	1168e5fa-f25e-499e-aba2-a296e13c6eeb
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	397f1001-01c3-4d16-87c8-6e019a075e5d
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	f4da04df-c7ce-46e1-b7b8-1a0617d52a42
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	259785ce-aab1-49f3-87dc-f40f089b1f98
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	aa329cfb-3424-480c-9982-2408884993d9
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	755f99d3-d36c-4510-9e57-fc7979bbc660
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	9b00a73c-8fe1-4f0c-9cd9-0eb5f2ca99eb
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	4fc7f4c1-44fa-4f43-a0d5-bca451726fab
3bc85df5-6bc3-4e9e-af2d-395c6acb9a8b	4fc7f4c1-44fa-4f43-a0d5-bca451726fab
3bc85df5-6bc3-4e9e-af2d-395c6acb9a8b	aa329cfb-3424-480c-9982-2408884993d9
3cf414b0-166e-48bc-8a46-0370a8083804	755f99d3-d36c-4510-9e57-fc7979bbc660
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	4e245bf1-194c-439c-9894-bc5cfb1f3bda
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	d9818237-2380-48cb-97b6-22edfef4616f
d9818237-2380-48cb-97b6-22edfef4616f	9d1efda5-5000-49bf-b7f3-34f599871f91
9b5a1997-44cc-4f83-9717-f8119ef05826	211b45d9-60ec-4639-b4c0-b879ad9bd7a9
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	a773b06d-71d1-440f-94df-b1cace2e2ecb
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	bb0fbd2a-a9ea-491a-bb07-43077c69a75f
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	2a192b74-989a-431a-8561-0490cccd5127
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	b97eeb3f-ce6e-4dd8-9fb4-e642b7f5aa63
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	e0a548ae-d084-4c95-bb53-3a73352f8544
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	f0ccc15b-b484-4cf6-9c3a-46c96671847d
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	42f29788-1b15-4e21-8a30-557cca6ce78f
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	1c3a6661-2384-4c88-865a-e10905cb1df0
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	a672d30b-7b2f-465c-b3b6-0dca9eb35dbe
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	564a1b2b-9a3e-4f1c-aeaa-79a6f5a51bd3
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	12e441c2-2b7b-4537-8ae6-f209fbccb7b1
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	8ce55e8d-b4ea-402c-8bbb-bc68c01af5bb
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	5e88c5be-1ad6-4f58-8c71-9308dd1c6c53
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	44393bb6-0368-454a-8e41-85aa2c459035
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	7e93bd2b-c6b5-462b-8986-92ce64787b65
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	5a04bcb4-a992-4c30-86eb-bfc9a98f9bcf
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	a4bcf54c-7db2-4ecd-8de8-b79921648bd9
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	3835389e-874b-4c3b-907c-00ad8fb84a1f
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	48f0a5ab-fd8d-41cd-802d-354e04bd465e
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	9ada0f4c-e590-4bd6-a5ec-a3ef7f6b0e84
42f29788-1b15-4e21-8a30-557cca6ce78f	3835389e-874b-4c3b-907c-00ad8fb84a1f
f0ccc15b-b484-4cf6-9c3a-46c96671847d	9ada0f4c-e590-4bd6-a5ec-a3ef7f6b0e84
f0ccc15b-b484-4cf6-9c3a-46c96671847d	a4bcf54c-7db2-4ecd-8de8-b79921648bd9
2081d8e6-514f-4657-9d1d-53793a4b8541	bcc26078-be43-4117-8b91-6b63aaf27dba
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	c4a8fc9f-eec4-4bbd-be24-4dc570912647
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	d5960db0-cdf3-4a89-b0d0-eeca83a8fc4b
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	7617a8e7-b10d-49ed-af40-9d67e3feeabf
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	a4424935-810e-4a54-9bbb-cfcbd48225eb
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	e551e446-0e35-42c2-8c1d-2113c1437119
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	a0672bf7-adf8-47b9-8f9f-c7404a2837b8
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	af332bd6-e6e5-4b23-8d77-d2d713344561
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	0b368515-81bb-4495-885a-c446a2a8d88a
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	fa4c8203-8ba0-4a4c-9926-e54677a95249
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	26b18375-6d0f-48a0-95c0-6974a9170ca3
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	6250e525-6ea5-4d61-ba73-ab9f1a50f1b7
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	93513462-0626-4bbe-9a47-c7af21f64d9e
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	3c2a6f91-30f8-4f5f-8ca2-154848349c49
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	bcc26078-be43-4117-8b91-6b63aaf27dba
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	320ec6f1-583d-4196-bb53-3d14b142b8cb
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	e87855d0-07c9-4b85-951c-4c6674cec921
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	3b7df7e6-c002-4cc5-b6cb-b8a728e7b347
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	2081d8e6-514f-4657-9d1d-53793a4b8541
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	981e392d-13ef-4996-a0f8-1002a184c8b1
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	a053142b-ded5-4d2e-b00f-7e4fbe0c74c8
d5960db0-cdf3-4a89-b0d0-eeca83a8fc4b	6250e525-6ea5-4d61-ba73-ab9f1a50f1b7
d5960db0-cdf3-4a89-b0d0-eeca83a8fc4b	93513462-0626-4bbe-9a47-c7af21f64d9e
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	ee9c7088-1bca-4d52-9a40-d6e92b624818
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
a42cefb7-6b95-41d2-8590-bdf2e3a0e149	\N	password	d26108fc-8b27-44f7-b0c0-043ee4106287	1724166467047	My password	{"value":"UtqqWz1upZiT6B7MfxV5YH308pjpvzY4iA9qCO9qYQpifQgD4wrkQOC/MtPMfgVI9CsU2vY5Xeb+vlfCeVF7VA==","salt":"FV/7EiDDMyKP08ULDkFlvA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
a977a505-46a0-40af-b6d5-85ef2599843d	\N	password	ad98ec1e-aef3-4406-9fe4-303945b69857	1724166414113	My password	{"value":"QHKp0Kwa1UrBKSCSdj47hwLW7SKCKbgD4uTV8Yqyts0hJzVM23QZlupnhwCxoMtq10Oy5k/mZMjKXlhRJH1dOQ==","salt":"SQJluSvveGVEXsX6xjU58w==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
84e18c08-6761-4d29-90a6-d823bbb6e8f6	\N	password	3e50cc9d-9922-4361-90fb-f7a953672011	1724228491221	My password	{"value":"mdK2mroxgFRt8I6eOD1nqfpss1xNUfusx0+kapEzuKvwjIu5F7ogFyAi74Xeut0eTgH8kqXylR4tf9uaMDwPdg==","salt":"EHYbeGJfWUZ9fFZ68LZLfg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
302600bb-80be-4e12-adf7-bb0f86f8c1cf	\N	password	ba29ced6-e2b1-4d96-9f26-bd9f8002e305	1724240931590	\N	{"value":"UnHkZL++sMlNSVoZDx3JIEAkqyd//mpj2BcnbVYxgCXgIkT/4mXM1wy6eHcjHkNBlMVRz2DEcjk42AMYkY7rsw==","salt":"2e9eTFy3ULXytkRwHr7YcA==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-08-21 08:52:16.640072	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	4230336058
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-08-21 08:52:16.66277	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	DEV	\N	\N	4230336058
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-08-21 08:52:16.72637	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	DEV	\N	\N	4230336058
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-08-21 08:52:16.73097	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	4230336058
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-08-21 08:52:16.922023	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	4230336058
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-08-21 08:52:16.929091	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	DEV	\N	\N	4230336058
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-08-21 08:52:17.024795	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	4230336058
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-08-21 08:52:17.03236	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	DEV	\N	\N	4230336058
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-08-21 08:52:17.047852	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	DEV	\N	\N	4230336058
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-08-21 08:52:17.194961	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	DEV	\N	\N	4230336058
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-08-21 08:52:17.259384	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	4230336058
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-08-21 08:52:17.265335	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	4230336058
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-08-21 08:52:17.293273	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	DEV	\N	\N	4230336058
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-21 08:52:17.317523	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	DEV	\N	\N	4230336058
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-21 08:52:17.31979	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	4230336058
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-21 08:52:17.323579	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	DEV	\N	\N	4230336058
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-08-21 08:52:17.327165	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	DEV	\N	\N	4230336058
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-08-21 08:52:17.376973	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	DEV	\N	\N	4230336058
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-08-21 08:52:17.432012	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	4230336058
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-08-21 08:52:17.438085	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	4230336058
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-21 08:52:17.976611	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	DEV	\N	\N	4230336058
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-08-21 08:52:17.442948	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	DEV	\N	\N	4230336058
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-08-21 08:52:17.447073	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	DEV	\N	\N	4230336058
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-08-21 08:52:17.478246	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	DEV	\N	\N	4230336058
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-08-21 08:52:17.485223	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	4230336058
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-08-21 08:52:17.487325	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	DEV	\N	\N	4230336058
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-08-21 08:52:17.524836	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	DEV	\N	\N	4230336058
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-08-21 08:52:17.615597	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	DEV	\N	\N	4230336058
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-08-21 08:52:17.619069	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	4230336058
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-08-21 08:52:17.690182	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	DEV	\N	\N	4230336058
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-08-21 08:52:17.70588	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	DEV	\N	\N	4230336058
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-08-21 08:52:17.732532	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	DEV	\N	\N	4230336058
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-08-21 08:52:17.740882	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	DEV	\N	\N	4230336058
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-21 08:52:17.75361	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	4230336058
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-21 08:52:17.756541	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	4230336058
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-21 08:52:17.788712	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	DEV	\N	\N	4230336058
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-08-21 08:52:17.795119	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	DEV	\N	\N	4230336058
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-08-21 08:52:17.802287	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	4230336058
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-08-21 08:52:17.807097	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	DEV	\N	\N	4230336058
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-08-21 08:52:17.811399	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	DEV	\N	\N	4230336058
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-21 08:52:17.813216	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	4230336058
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-21 08:52:17.818441	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	DEV	\N	\N	4230336058
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-08-21 08:52:17.829039	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	DEV	\N	\N	4230336058
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-08-21 08:52:17.95852	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	DEV	\N	\N	4230336058
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-08-21 08:52:17.963298	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	DEV	\N	\N	4230336058
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-21 08:52:17.968411	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	4230336058
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-21 08:52:17.978967	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	DEV	\N	\N	4230336058
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-21 08:52:18.015472	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	DEV	\N	\N	4230336058
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-08-21 08:52:18.019448	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	DEV	\N	\N	4230336058
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-08-21 08:52:18.055397	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	DEV	\N	\N	4230336058
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-08-21 08:52:18.087576	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	DEV	\N	\N	4230336058
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-08-21 08:52:18.093054	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-08-21 08:52:18.096646	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	DEV	\N	\N	4230336058
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-08-21 08:52:18.099745	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	DEV	\N	\N	4230336058
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-21 08:52:18.107321	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	DEV	\N	\N	4230336058
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-21 08:52:18.11152	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	DEV	\N	\N	4230336058
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-21 08:52:18.136165	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	DEV	\N	\N	4230336058
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-08-21 08:52:18.299322	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	DEV	\N	\N	4230336058
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-08-21 08:52:18.339557	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	DEV	\N	\N	4230336058
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-08-21 08:52:18.34728	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	DEV	\N	\N	4230336058
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-08-21 08:52:18.360024	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	DEV	\N	\N	4230336058
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-08-21 08:52:18.374446	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	DEV	\N	\N	4230336058
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-08-21 08:52:18.380811	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	4230336058
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-08-21 08:52:18.385591	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	DEV	\N	\N	4230336058
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-08-21 08:52:18.390318	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	DEV	\N	\N	4230336058
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-08-21 08:52:18.418718	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	DEV	\N	\N	4230336058
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-08-21 08:52:18.431429	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	DEV	\N	\N	4230336058
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-08-21 08:52:18.438895	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	DEV	\N	\N	4230336058
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-08-21 08:52:18.45897	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	DEV	\N	\N	4230336058
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-08-21 08:52:18.467791	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	DEV	\N	\N	4230336058
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-08-21 08:52:18.474416	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	DEV	\N	\N	4230336058
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-21 08:52:18.48245	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	4230336058
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-21 08:52:18.49029	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	4230336058
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-21 08:52:18.493495	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	DEV	\N	\N	4230336058
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-21 08:52:18.514382	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	DEV	\N	\N	4230336058
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-08-21 08:52:18.530371	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	DEV	\N	\N	4230336058
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-21 08:52:18.538807	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	DEV	\N	\N	4230336058
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-21 08:52:18.542231	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	DEV	\N	\N	4230336058
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-21 08:52:18.569012	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	DEV	\N	\N	4230336058
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-08-21 08:52:18.572205	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	DEV	\N	\N	4230336058
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-21 08:52:18.58173	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	DEV	\N	\N	4230336058
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-21 08:52:18.583924	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	4230336058
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-21 08:52:18.591238	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	4230336058
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-21 08:52:18.594253	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	DEV	\N	\N	4230336058
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-08-21 08:52:18.604374	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	DEV	\N	\N	4230336058
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-08-21 08:52:18.611383	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	DEV	\N	\N	4230336058
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-08-21 08:52:18.619961	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	DEV	\N	\N	4230336058
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-08-21 08:52:18.641349	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	DEV	\N	\N	4230336058
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.654179	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	DEV	\N	\N	4230336058
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.661607	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	DEV	\N	\N	4230336058
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.673785	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	4230336058
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.684093	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	DEV	\N	\N	4230336058
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.688434	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	4230336058
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.703075	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	DEV	\N	\N	4230336058
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-21 08:52:19.190845	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.705927	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	DEV	\N	\N	4230336058
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-08-21 08:52:18.71587	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	DEV	\N	\N	4230336058
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.738813	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	DEV	\N	\N	4230336058
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.741719	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.751745	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.761907	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.764036	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.773289	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	DEV	\N	\N	4230336058
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-08-21 08:52:18.781029	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	DEV	\N	\N	4230336058
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-08-21 08:52:18.787343	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	DEV	\N	\N	4230336058
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-08-21 08:52:18.800615	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	DEV	\N	\N	4230336058
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-08-21 08:52:18.812697	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	DEV	\N	\N	4230336058
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2024-08-21 08:52:18.827684	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	DEV	\N	\N	4230336058
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-08-21 08:52:18.833976	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	DEV	\N	\N	4230336058
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-21 08:52:18.84633	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	DEV	\N	\N	4230336058
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-21 08:52:18.850113	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	DEV	\N	\N	4230336058
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-08-21 08:52:18.861324	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-08-21 08:52:18.868654	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	DEV	\N	\N	4230336058
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-08-21 08:52:18.924402	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	DEV	\N	\N	4230336058
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-08-21 08:52:18.936224	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	DEV	\N	\N	4230336058
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-08-21 08:52:18.952167	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	DEV	\N	\N	4230336058
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-08-21 08:52:18.9675	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	DEV	\N	\N	4230336058
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-08-21 08:52:18.992063	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	DEV	\N	\N	4230336058
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-08-21 08:52:19.015651	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	DEV	\N	\N	4230336058
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-21 08:52:19.126022	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	DEV	\N	\N	4230336058
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-21 08:52:19.137946	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	DEV	\N	\N	4230336058
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-08-21 08:52:19.148909	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-21 08:52:19.206199	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	DEV	\N	\N	4230336058
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-21 08:52:19.22232	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-08-21 08:52:19.231954	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	DEV	\N	\N	4230336058
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
527fc094-fada-4190-a49a-737d201c5c4c	6614952e-03a5-481d-9dc1-6afe746e551c	f
527fc094-fada-4190-a49a-737d201c5c4c	07eefa70-939b-4081-bf48-0eef48b02db4	t
527fc094-fada-4190-a49a-737d201c5c4c	f3da7958-fe87-4152-a66a-0268033f287f	t
527fc094-fada-4190-a49a-737d201c5c4c	38a21469-2bf2-48c7-b294-b690ecc5ae0f	t
527fc094-fada-4190-a49a-737d201c5c4c	40c5df01-4571-4c08-8ff0-a7a75e04e592	f
527fc094-fada-4190-a49a-737d201c5c4c	63a01feb-58de-40ad-b3e2-965a66043d9d	f
527fc094-fada-4190-a49a-737d201c5c4c	414e1893-0da7-4950-9081-302b335d09eb	t
527fc094-fada-4190-a49a-737d201c5c4c	0653ab45-7b02-44b5-abcb-0aafb5875f32	t
527fc094-fada-4190-a49a-737d201c5c4c	6294c724-64dc-4c44-838c-6380897b8c0e	f
527fc094-fada-4190-a49a-737d201c5c4c	216460d6-cf71-4a35-88f7-5b334d1a25c5	t
e214324c-91eb-4614-b756-7470275d6389	dd8c9029-1969-46e9-b098-83cdbce76e86	t
e214324c-91eb-4614-b756-7470275d6389	12ba1413-0920-478f-80d7-0e34b8c8fecc	t
e214324c-91eb-4614-b756-7470275d6389	3fc192f8-eebb-464c-90c1-5a0af885cb80	t
e214324c-91eb-4614-b756-7470275d6389	001064ca-bf3a-4b1b-94de-40e0fc817d1d	t
e214324c-91eb-4614-b756-7470275d6389	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d	t
e214324c-91eb-4614-b756-7470275d6389	1451242f-55d5-4eeb-877d-038c96080dfd	t
e214324c-91eb-4614-b756-7470275d6389	1dc8eda7-f5a2-4e16-8f38-ffa56201aee9	f
e214324c-91eb-4614-b756-7470275d6389	6387d083-9198-4f81-9f96-55d60b84e9b9	f
e214324c-91eb-4614-b756-7470275d6389	dd35585d-392c-42b1-b43e-2729c10fe338	f
e214324c-91eb-4614-b756-7470275d6389	36071bb1-2e70-47fd-a7d1-927d06c02ce6	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
19a27783-789c-4cc2-bd4f-08b43279f666	principals	 	e214324c-91eb-4614-b756-7470275d6389
9ab58f70-5d35-49a7-847f-a35bca46eae4	seniors	 	e214324c-91eb-4614-b756-7470275d6389
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	527fc094-fada-4190-a49a-737d201c5c4c	f	${role_default-roles}	default-roles-master	527fc094-fada-4190-a49a-737d201c5c4c	\N	\N
10819cf3-d54f-48b3-a4d2-5630f4c23e27	527fc094-fada-4190-a49a-737d201c5c4c	f	${role_create-realm}	create-realm	527fc094-fada-4190-a49a-737d201c5c4c	\N	\N
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	527fc094-fada-4190-a49a-737d201c5c4c	f	${role_admin}	admin	527fc094-fada-4190-a49a-737d201c5c4c	\N	\N
1e8b1271-66cd-4dae-944b-ec7b967ac449	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_create-client}	create-client	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
9260374a-a753-4b60-9d1c-3c0e94cb9934	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-realm}	view-realm	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
3bc85df5-6bc3-4e9e-af2d-395c6acb9a8b	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-users}	view-users	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
3cf414b0-166e-48bc-8a46-0370a8083804	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-clients}	view-clients	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
e439ce5c-2426-4368-9ca0-97950bac2806	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-events}	view-events	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
bf8b3a61-4e4b-46e7-9833-0b7b01796572	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-identity-providers}	view-identity-providers	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
377d6a09-36df-46f6-8399-9ab6c3ac053c	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_view-authorization}	view-authorization	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
807bbafb-8eac-4ec0-b35d-3df7f9ee6b6b	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-realm}	manage-realm	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
ad396ebd-8f59-4f7b-92be-3ad606442db7	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-users}	manage-users	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
1168e5fa-f25e-499e-aba2-a296e13c6eeb	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-clients}	manage-clients	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
397f1001-01c3-4d16-87c8-6e019a075e5d	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-events}	manage-events	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
f4da04df-c7ce-46e1-b7b8-1a0617d52a42	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-identity-providers}	manage-identity-providers	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
259785ce-aab1-49f3-87dc-f40f089b1f98	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_manage-authorization}	manage-authorization	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
aa329cfb-3424-480c-9982-2408884993d9	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_query-users}	query-users	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
755f99d3-d36c-4510-9e57-fc7979bbc660	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_query-clients}	query-clients	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
9b00a73c-8fe1-4f0c-9cd9-0eb5f2ca99eb	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_query-realms}	query-realms	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
4fc7f4c1-44fa-4f43-a0d5-bca451726fab	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_query-groups}	query-groups	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
4e245bf1-194c-439c-9894-bc5cfb1f3bda	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_view-profile}	view-profile	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
d9818237-2380-48cb-97b6-22edfef4616f	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_manage-account}	manage-account	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
9d1efda5-5000-49bf-b7f3-34f599871f91	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_manage-account-links}	manage-account-links	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
5c95b8e0-6e27-443f-8e7c-6d13d7254fe8	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_view-applications}	view-applications	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
211b45d9-60ec-4639-b4c0-b879ad9bd7a9	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_view-consent}	view-consent	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
9b5a1997-44cc-4f83-9717-f8119ef05826	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_manage-consent}	manage-consent	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
b3b23b42-e408-4938-b8e5-e51aef7cd520	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_view-groups}	view-groups	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
bcbe6ffa-9b56-4751-91f8-8dbbd98e52a6	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	t	${role_delete-account}	delete-account	527fc094-fada-4190-a49a-737d201c5c4c	cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	\N
8adbf127-5403-4e04-9a5d-184ab24a096b	f566a3c8-ba06-473d-9761-0d69de489bc3	t	${role_read-token}	read-token	527fc094-fada-4190-a49a-737d201c5c4c	f566a3c8-ba06-473d-9761-0d69de489bc3	\N
a773b06d-71d1-440f-94df-b1cace2e2ecb	d845197a-8f81-4129-ba71-08d654fc8706	t	${role_impersonation}	impersonation	527fc094-fada-4190-a49a-737d201c5c4c	d845197a-8f81-4129-ba71-08d654fc8706	\N
bb0fbd2a-a9ea-491a-bb07-43077c69a75f	527fc094-fada-4190-a49a-737d201c5c4c	f	${role_offline-access}	offline_access	527fc094-fada-4190-a49a-737d201c5c4c	\N	\N
2a192b74-989a-431a-8561-0490cccd5127	527fc094-fada-4190-a49a-737d201c5c4c	f	${role_uma_authorization}	uma_authorization	527fc094-fada-4190-a49a-737d201c5c4c	\N	\N
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	e214324c-91eb-4614-b756-7470275d6389	f	${role_default-roles}	default-roles-csa	e214324c-91eb-4614-b756-7470275d6389	\N	\N
b97eeb3f-ce6e-4dd8-9fb4-e642b7f5aa63	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_create-client}	create-client	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
e0a548ae-d084-4c95-bb53-3a73352f8544	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-realm}	view-realm	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
f0ccc15b-b484-4cf6-9c3a-46c96671847d	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-users}	view-users	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
42f29788-1b15-4e21-8a30-557cca6ce78f	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-clients}	view-clients	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
1c3a6661-2384-4c88-865a-e10905cb1df0	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-events}	view-events	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
a672d30b-7b2f-465c-b3b6-0dca9eb35dbe	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-identity-providers}	view-identity-providers	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
564a1b2b-9a3e-4f1c-aeaa-79a6f5a51bd3	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_view-authorization}	view-authorization	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
12e441c2-2b7b-4537-8ae6-f209fbccb7b1	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-realm}	manage-realm	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
8ce55e8d-b4ea-402c-8bbb-bc68c01af5bb	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-users}	manage-users	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
5e88c5be-1ad6-4f58-8c71-9308dd1c6c53	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-clients}	manage-clients	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
44393bb6-0368-454a-8e41-85aa2c459035	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-events}	manage-events	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
7e93bd2b-c6b5-462b-8986-92ce64787b65	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-identity-providers}	manage-identity-providers	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
5a04bcb4-a992-4c30-86eb-bfc9a98f9bcf	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_manage-authorization}	manage-authorization	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
a4bcf54c-7db2-4ecd-8de8-b79921648bd9	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_query-users}	query-users	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
3835389e-874b-4c3b-907c-00ad8fb84a1f	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_query-clients}	query-clients	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
48f0a5ab-fd8d-41cd-802d-354e04bd465e	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_query-realms}	query-realms	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
9ada0f4c-e590-4bd6-a5ec-a3ef7f6b0e84	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_query-groups}	query-groups	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
981e392d-13ef-4996-a0f8-1002a184c8b1	e214324c-91eb-4614-b756-7470275d6389	f	${role_uma_authorization}	uma_authorization	e214324c-91eb-4614-b756-7470275d6389	\N	\N
a053142b-ded5-4d2e-b00f-7e4fbe0c74c8	e214324c-91eb-4614-b756-7470275d6389	f	${role_offline-access}	offline_access	e214324c-91eb-4614-b756-7470275d6389	\N	\N
489babdc-82cc-410f-954d-ff525a1af70f	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	t	\N	manage-account	e214324c-91eb-4614-b756-7470275d6389	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	\N
871278fb-47bf-442a-98a4-d47b60768a66	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	t	\N	view-groups	e214324c-91eb-4614-b756-7470275d6389	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	\N
1d07baa6-f279-4cf9-ad6b-94862075d7c6	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	t	${role_delete-account}	delete-account	e214324c-91eb-4614-b756-7470275d6389	31e21bd5-5ea5-4b69-b659-a9e29cfe1704	\N
c4a8fc9f-eec4-4bbd-be24-4dc570912647	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-identity-providers}	manage-identity-providers	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
d5960db0-cdf3-4a89-b0d0-eeca83a8fc4b	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-users}	view-users	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
7617a8e7-b10d-49ed-af40-9d67e3feeabf	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_create-client}	create-client	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
a4424935-810e-4a54-9bbb-cfcbd48225eb	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_query-realms}	query-realms	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
e551e446-0e35-42c2-8c1d-2113c1437119	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_impersonation}	impersonation	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
a0672bf7-adf8-47b9-8f9f-c7404a2837b8	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-realm}	view-realm	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
591fe52f-4ea6-426a-b9ed-7bbcbd2742ba	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_realm-admin}	realm-admin	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
af332bd6-e6e5-4b23-8d77-d2d713344561	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-events}	view-events	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
0b368515-81bb-4495-885a-c446a2a8d88a	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-identity-providers}	view-identity-providers	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
fa4c8203-8ba0-4a4c-9926-e54677a95249	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-authorization}	manage-authorization	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
26b18375-6d0f-48a0-95c0-6974a9170ca3	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-authorization}	view-authorization	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
6250e525-6ea5-4d61-ba73-ab9f1a50f1b7	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_query-groups}	query-groups	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
93513462-0626-4bbe-9a47-c7af21f64d9e	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_query-users}	query-users	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
3c2a6f91-30f8-4f5f-8ca2-154848349c49	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-events}	manage-events	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
bcc26078-be43-4117-8b91-6b63aaf27dba	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_query-clients}	query-clients	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
320ec6f1-583d-4196-bb53-3d14b142b8cb	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-realm}	manage-realm	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
e87855d0-07c9-4b85-951c-4c6674cec921	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-clients}	manage-clients	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
3b7df7e6-c002-4cc5-b6cb-b8a728e7b347	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_manage-users}	manage-users	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
2081d8e6-514f-4657-9d1d-53793a4b8541	81ec4301-bb48-4be1-b1b2-f39d729b51a0	t	${role_view-clients}	view-clients	e214324c-91eb-4614-b756-7470275d6389	81ec4301-bb48-4be1-b1b2-f39d729b51a0	\N
ee9c7088-1bca-4d52-9a40-d6e92b624818	e142ec1f-d516-4533-9e12-ed3e100818c8	t	${role_impersonation}	impersonation	527fc094-fada-4190-a49a-737d201c5c4c	e142ec1f-d516-4533-9e12-ed3e100818c8	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ageol	24.0.6	1724230339
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
ad83d904-fd51-4b24-a62e-214dd660f8af	audience resolve	openid-connect	oidc-audience-resolve-mapper	3c3eab9f-45df-4b5f-bf9d-b33371593045	\N
eb913ccc-da16-4020-9517-70327fb8623b	locale	openid-connect	oidc-usermodel-attribute-mapper	8152e404-de3a-4404-a139-aa7feb9dba14	\N
c67243a0-0654-484e-9a78-8c9ca56e5131	role list	saml	saml-role-list-mapper	\N	07eefa70-939b-4081-bf48-0eef48b02db4
0aaaf669-6998-4fc7-9cd0-75fdc11911f7	full name	openid-connect	oidc-full-name-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
be5bada7-b172-4517-b749-2759140b4d31	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
3eee2a8d-f6e1-4264-9f78-115c40e15de6	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
ee386171-8f16-4a25-a93e-36c57ff7dde6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
f12e4d99-8106-490f-b7ab-8f955dbb92ee	username	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
0dbacc8f-d4ce-4615-b817-febf28ff87ed	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
802a54a7-3bdc-49a4-a622-7838b01bdd46	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
f7a6567e-c75a-4afe-9854-f5c790410a9c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
f99324df-d182-4139-ba35-ca4c74f254d0	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
f2654cb2-418f-4597-9c28-8991e1150cc0	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
8d5b8bc2-dd20-40da-b955-517787bbfe2f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f3da7958-fe87-4152-a66a-0268033f287f
e824193d-7a21-4dcb-981a-141c35f16526	email	openid-connect	oidc-usermodel-attribute-mapper	\N	38a21469-2bf2-48c7-b294-b690ecc5ae0f
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	email verified	openid-connect	oidc-usermodel-property-mapper	\N	38a21469-2bf2-48c7-b294-b690ecc5ae0f
40957026-0ba2-45e5-9e29-76e25c153389	address	openid-connect	oidc-address-mapper	\N	40c5df01-4571-4c08-8ff0-a7a75e04e592
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	63a01feb-58de-40ad-b3e2-965a66043d9d
305275d2-4cee-411f-83a0-44e308060a2a	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	63a01feb-58de-40ad-b3e2-965a66043d9d
81c90024-b84c-4e73-9134-0959d7cba5f4	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	414e1893-0da7-4950-9081-302b335d09eb
572bb950-3fc0-4182-89f5-2956208eb728	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	414e1893-0da7-4950-9081-302b335d09eb
a78f63c6-9f90-465d-b235-f402ceccef23	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	414e1893-0da7-4950-9081-302b335d09eb
d059a829-a742-4482-8675-db22eaff26b4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	0653ab45-7b02-44b5-abcb-0aafb5875f32
65ac1a96-1879-4942-a2f3-706ace09120a	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	6294c724-64dc-4c44-838c-6380897b8c0e
f194c7d9-2d30-4f2f-b18f-548ec2663650	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	6294c724-64dc-4c44-838c-6380897b8c0e
61c46335-8071-4951-b873-b55200b1e041	acr loa level	openid-connect	oidc-acr-mapper	\N	216460d6-cf71-4a35-88f7-5b334d1a25c5
ee3178b3-a9e3-4e57-9990-d8e0eb49b448	role list	saml	saml-role-list-mapper	\N	dd8c9029-1969-46e9-b098-83cdbce76e86
ad721224-0a24-4ee6-a6e3-b83636dc0e40	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	001064ca-bf3a-4b1b-94de-40e0fc817d1d
9d24d35f-d9c1-458a-9552-ad84130344be	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	001064ca-bf3a-4b1b-94de-40e0fc817d1d
82ffb219-080e-4f81-9e48-26bc8337ca2b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	001064ca-bf3a-4b1b-94de-40e0fc817d1d
a5aa28d6-7c6f-459d-9394-1af557228133	address	openid-connect	oidc-address-mapper	\N	6387d083-9198-4f81-9f96-55d60b84e9b9
15acc04b-7253-4088-a1a9-8473e400b284	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	dd35585d-392c-42b1-b43e-2729c10fe338
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	dd35585d-392c-42b1-b43e-2729c10fe338
259708c3-7120-46ee-add9-6acc765336f4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e8049765-52d1-4c6f-8ecb-1cf5510f1f5d
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	3fc192f8-eebb-464c-90c1-5a0af885cb80
9abed63b-5a1e-4550-bc27-477e0a14ea0a	email	openid-connect	oidc-usermodel-attribute-mapper	\N	3fc192f8-eebb-464c-90c1-5a0af885cb80
63733c41-21d9-42d9-8e5a-b745fabc8733	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	36071bb1-2e70-47fd-a7d1-927d06c02ce6
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	36071bb1-2e70-47fd-a7d1-927d06c02ce6
ab87ad08-bba9-421e-a139-60f2ef29e321	acr loa level	openid-connect	oidc-acr-mapper	\N	1451242f-55d5-4eeb-877d-038c96080dfd
30a057c2-e98f-4d59-a649-e5ad9721bacc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
17b7832a-dde5-40ea-828f-5c48be985b07	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
6849c517-f957-4e06-b912-3d466339bd82	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
3c8ae703-d90b-4181-a00c-b81f05ff9575	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
caeaf05a-063c-46d0-8f2e-1937ffe68c70	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
9d47e7d5-d70c-485c-b72d-801bd1ca019b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
1cb5da4b-1661-4623-af9c-b6c912ef6d58	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
91a26f7c-e959-467b-950a-782bac2a6398	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
6413f072-e1ac-4fd1-8cae-eff05552b4cf	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
feeecbfd-9b7f-4735-959c-96d69e017c1e	username	openid-connect	oidc-usermodel-attribute-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
42a72efc-3db9-454f-976b-f4e750bfdaf3	full name	openid-connect	oidc-full-name-mapper	\N	12ba1413-0920-478f-80d7-0e34b8c8fecc
ba112c46-633b-4214-8ab5-591312c4461a	audience resolve	openid-connect	oidc-audience-resolve-mapper	dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	\N
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	locale	openid-connect	oidc-usermodel-attribute-mapper	cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	\N
b8d7026d-bdf5-4134-8d13-2133112aa3d5	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	\N
9325a053-e91a-4e66-8634-a185460d4044	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	\N
5ed0a115-3202-4ddc-83d4-272aec10f265	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
eb913ccc-da16-4020-9517-70327fb8623b	true	introspection.token.claim
eb913ccc-da16-4020-9517-70327fb8623b	true	userinfo.token.claim
eb913ccc-da16-4020-9517-70327fb8623b	locale	user.attribute
eb913ccc-da16-4020-9517-70327fb8623b	true	id.token.claim
eb913ccc-da16-4020-9517-70327fb8623b	true	access.token.claim
eb913ccc-da16-4020-9517-70327fb8623b	locale	claim.name
eb913ccc-da16-4020-9517-70327fb8623b	String	jsonType.label
c67243a0-0654-484e-9a78-8c9ca56e5131	false	single
c67243a0-0654-484e-9a78-8c9ca56e5131	Basic	attribute.nameformat
c67243a0-0654-484e-9a78-8c9ca56e5131	Role	attribute.name
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	true	introspection.token.claim
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	true	userinfo.token.claim
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	updatedAt	user.attribute
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	true	id.token.claim
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	true	access.token.claim
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	updated_at	claim.name
038a4607-d987-4d3d-a2c8-d37d2c8d50c8	long	jsonType.label
0aaaf669-6998-4fc7-9cd0-75fdc11911f7	true	introspection.token.claim
0aaaf669-6998-4fc7-9cd0-75fdc11911f7	true	userinfo.token.claim
0aaaf669-6998-4fc7-9cd0-75fdc11911f7	true	id.token.claim
0aaaf669-6998-4fc7-9cd0-75fdc11911f7	true	access.token.claim
0dbacc8f-d4ce-4615-b817-febf28ff87ed	true	introspection.token.claim
0dbacc8f-d4ce-4615-b817-febf28ff87ed	true	userinfo.token.claim
0dbacc8f-d4ce-4615-b817-febf28ff87ed	profile	user.attribute
0dbacc8f-d4ce-4615-b817-febf28ff87ed	true	id.token.claim
0dbacc8f-d4ce-4615-b817-febf28ff87ed	true	access.token.claim
0dbacc8f-d4ce-4615-b817-febf28ff87ed	profile	claim.name
0dbacc8f-d4ce-4615-b817-febf28ff87ed	String	jsonType.label
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	true	introspection.token.claim
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	true	userinfo.token.claim
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	gender	user.attribute
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	true	id.token.claim
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	true	access.token.claim
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	gender	claim.name
2420fee9-bcfc-47dd-a8cc-9866c6bd7d1a	String	jsonType.label
3eee2a8d-f6e1-4264-9f78-115c40e15de6	true	introspection.token.claim
3eee2a8d-f6e1-4264-9f78-115c40e15de6	true	userinfo.token.claim
3eee2a8d-f6e1-4264-9f78-115c40e15de6	firstName	user.attribute
3eee2a8d-f6e1-4264-9f78-115c40e15de6	true	id.token.claim
3eee2a8d-f6e1-4264-9f78-115c40e15de6	true	access.token.claim
3eee2a8d-f6e1-4264-9f78-115c40e15de6	given_name	claim.name
3eee2a8d-f6e1-4264-9f78-115c40e15de6	String	jsonType.label
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	true	introspection.token.claim
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	true	userinfo.token.claim
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	middleName	user.attribute
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	true	id.token.claim
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	true	access.token.claim
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	middle_name	claim.name
43d0b46f-baa9-46c5-b55e-254e1fa9d88c	String	jsonType.label
802a54a7-3bdc-49a4-a622-7838b01bdd46	true	introspection.token.claim
802a54a7-3bdc-49a4-a622-7838b01bdd46	true	userinfo.token.claim
802a54a7-3bdc-49a4-a622-7838b01bdd46	picture	user.attribute
802a54a7-3bdc-49a4-a622-7838b01bdd46	true	id.token.claim
802a54a7-3bdc-49a4-a622-7838b01bdd46	true	access.token.claim
802a54a7-3bdc-49a4-a622-7838b01bdd46	picture	claim.name
802a54a7-3bdc-49a4-a622-7838b01bdd46	String	jsonType.label
8d5b8bc2-dd20-40da-b955-517787bbfe2f	true	introspection.token.claim
8d5b8bc2-dd20-40da-b955-517787bbfe2f	true	userinfo.token.claim
8d5b8bc2-dd20-40da-b955-517787bbfe2f	locale	user.attribute
8d5b8bc2-dd20-40da-b955-517787bbfe2f	true	id.token.claim
8d5b8bc2-dd20-40da-b955-517787bbfe2f	true	access.token.claim
8d5b8bc2-dd20-40da-b955-517787bbfe2f	locale	claim.name
8d5b8bc2-dd20-40da-b955-517787bbfe2f	String	jsonType.label
be5bada7-b172-4517-b749-2759140b4d31	true	introspection.token.claim
be5bada7-b172-4517-b749-2759140b4d31	true	userinfo.token.claim
be5bada7-b172-4517-b749-2759140b4d31	lastName	user.attribute
be5bada7-b172-4517-b749-2759140b4d31	true	id.token.claim
be5bada7-b172-4517-b749-2759140b4d31	true	access.token.claim
be5bada7-b172-4517-b749-2759140b4d31	family_name	claim.name
be5bada7-b172-4517-b749-2759140b4d31	String	jsonType.label
ee386171-8f16-4a25-a93e-36c57ff7dde6	true	introspection.token.claim
ee386171-8f16-4a25-a93e-36c57ff7dde6	true	userinfo.token.claim
ee386171-8f16-4a25-a93e-36c57ff7dde6	nickname	user.attribute
ee386171-8f16-4a25-a93e-36c57ff7dde6	true	id.token.claim
ee386171-8f16-4a25-a93e-36c57ff7dde6	true	access.token.claim
ee386171-8f16-4a25-a93e-36c57ff7dde6	nickname	claim.name
ee386171-8f16-4a25-a93e-36c57ff7dde6	String	jsonType.label
f12e4d99-8106-490f-b7ab-8f955dbb92ee	true	introspection.token.claim
f12e4d99-8106-490f-b7ab-8f955dbb92ee	true	userinfo.token.claim
f12e4d99-8106-490f-b7ab-8f955dbb92ee	username	user.attribute
f12e4d99-8106-490f-b7ab-8f955dbb92ee	true	id.token.claim
f12e4d99-8106-490f-b7ab-8f955dbb92ee	true	access.token.claim
f12e4d99-8106-490f-b7ab-8f955dbb92ee	preferred_username	claim.name
f12e4d99-8106-490f-b7ab-8f955dbb92ee	String	jsonType.label
f2654cb2-418f-4597-9c28-8991e1150cc0	true	introspection.token.claim
f2654cb2-418f-4597-9c28-8991e1150cc0	true	userinfo.token.claim
f2654cb2-418f-4597-9c28-8991e1150cc0	zoneinfo	user.attribute
f2654cb2-418f-4597-9c28-8991e1150cc0	true	id.token.claim
f2654cb2-418f-4597-9c28-8991e1150cc0	true	access.token.claim
f2654cb2-418f-4597-9c28-8991e1150cc0	zoneinfo	claim.name
f2654cb2-418f-4597-9c28-8991e1150cc0	String	jsonType.label
f7a6567e-c75a-4afe-9854-f5c790410a9c	true	introspection.token.claim
f7a6567e-c75a-4afe-9854-f5c790410a9c	true	userinfo.token.claim
f7a6567e-c75a-4afe-9854-f5c790410a9c	website	user.attribute
f7a6567e-c75a-4afe-9854-f5c790410a9c	true	id.token.claim
f7a6567e-c75a-4afe-9854-f5c790410a9c	true	access.token.claim
f7a6567e-c75a-4afe-9854-f5c790410a9c	website	claim.name
f7a6567e-c75a-4afe-9854-f5c790410a9c	String	jsonType.label
f99324df-d182-4139-ba35-ca4c74f254d0	true	introspection.token.claim
f99324df-d182-4139-ba35-ca4c74f254d0	true	userinfo.token.claim
f99324df-d182-4139-ba35-ca4c74f254d0	birthdate	user.attribute
f99324df-d182-4139-ba35-ca4c74f254d0	true	id.token.claim
f99324df-d182-4139-ba35-ca4c74f254d0	true	access.token.claim
f99324df-d182-4139-ba35-ca4c74f254d0	birthdate	claim.name
f99324df-d182-4139-ba35-ca4c74f254d0	String	jsonType.label
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	true	introspection.token.claim
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	true	userinfo.token.claim
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	emailVerified	user.attribute
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	true	id.token.claim
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	true	access.token.claim
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	email_verified	claim.name
d99c1fb6-5ea4-40c7-a436-ef4a9b79a891	boolean	jsonType.label
e824193d-7a21-4dcb-981a-141c35f16526	true	introspection.token.claim
e824193d-7a21-4dcb-981a-141c35f16526	true	userinfo.token.claim
e824193d-7a21-4dcb-981a-141c35f16526	email	user.attribute
e824193d-7a21-4dcb-981a-141c35f16526	true	id.token.claim
e824193d-7a21-4dcb-981a-141c35f16526	true	access.token.claim
e824193d-7a21-4dcb-981a-141c35f16526	email	claim.name
e824193d-7a21-4dcb-981a-141c35f16526	String	jsonType.label
40957026-0ba2-45e5-9e29-76e25c153389	formatted	user.attribute.formatted
40957026-0ba2-45e5-9e29-76e25c153389	country	user.attribute.country
40957026-0ba2-45e5-9e29-76e25c153389	true	introspection.token.claim
40957026-0ba2-45e5-9e29-76e25c153389	postal_code	user.attribute.postal_code
40957026-0ba2-45e5-9e29-76e25c153389	true	userinfo.token.claim
40957026-0ba2-45e5-9e29-76e25c153389	street	user.attribute.street
40957026-0ba2-45e5-9e29-76e25c153389	true	id.token.claim
40957026-0ba2-45e5-9e29-76e25c153389	region	user.attribute.region
40957026-0ba2-45e5-9e29-76e25c153389	true	access.token.claim
40957026-0ba2-45e5-9e29-76e25c153389	locality	user.attribute.locality
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	true	introspection.token.claim
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	true	userinfo.token.claim
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	phoneNumber	user.attribute
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	true	id.token.claim
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	true	access.token.claim
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	phone_number	claim.name
0f2ab6c0-b9b6-49b1-a360-506e7f285eb4	String	jsonType.label
305275d2-4cee-411f-83a0-44e308060a2a	true	introspection.token.claim
305275d2-4cee-411f-83a0-44e308060a2a	true	userinfo.token.claim
305275d2-4cee-411f-83a0-44e308060a2a	phoneNumberVerified	user.attribute
305275d2-4cee-411f-83a0-44e308060a2a	true	id.token.claim
305275d2-4cee-411f-83a0-44e308060a2a	true	access.token.claim
305275d2-4cee-411f-83a0-44e308060a2a	phone_number_verified	claim.name
305275d2-4cee-411f-83a0-44e308060a2a	boolean	jsonType.label
572bb950-3fc0-4182-89f5-2956208eb728	true	introspection.token.claim
572bb950-3fc0-4182-89f5-2956208eb728	true	multivalued
572bb950-3fc0-4182-89f5-2956208eb728	foo	user.attribute
572bb950-3fc0-4182-89f5-2956208eb728	true	access.token.claim
572bb950-3fc0-4182-89f5-2956208eb728	resource_access.${client_id}.roles	claim.name
572bb950-3fc0-4182-89f5-2956208eb728	String	jsonType.label
81c90024-b84c-4e73-9134-0959d7cba5f4	true	introspection.token.claim
81c90024-b84c-4e73-9134-0959d7cba5f4	true	multivalued
81c90024-b84c-4e73-9134-0959d7cba5f4	foo	user.attribute
81c90024-b84c-4e73-9134-0959d7cba5f4	true	access.token.claim
81c90024-b84c-4e73-9134-0959d7cba5f4	realm_access.roles	claim.name
81c90024-b84c-4e73-9134-0959d7cba5f4	String	jsonType.label
a78f63c6-9f90-465d-b235-f402ceccef23	true	introspection.token.claim
a78f63c6-9f90-465d-b235-f402ceccef23	true	access.token.claim
d059a829-a742-4482-8675-db22eaff26b4	true	introspection.token.claim
d059a829-a742-4482-8675-db22eaff26b4	true	access.token.claim
65ac1a96-1879-4942-a2f3-706ace09120a	true	introspection.token.claim
65ac1a96-1879-4942-a2f3-706ace09120a	true	userinfo.token.claim
65ac1a96-1879-4942-a2f3-706ace09120a	username	user.attribute
65ac1a96-1879-4942-a2f3-706ace09120a	true	id.token.claim
65ac1a96-1879-4942-a2f3-706ace09120a	true	access.token.claim
65ac1a96-1879-4942-a2f3-706ace09120a	upn	claim.name
65ac1a96-1879-4942-a2f3-706ace09120a	String	jsonType.label
f194c7d9-2d30-4f2f-b18f-548ec2663650	true	introspection.token.claim
f194c7d9-2d30-4f2f-b18f-548ec2663650	true	multivalued
f194c7d9-2d30-4f2f-b18f-548ec2663650	foo	user.attribute
f194c7d9-2d30-4f2f-b18f-548ec2663650	true	id.token.claim
f194c7d9-2d30-4f2f-b18f-548ec2663650	true	access.token.claim
f194c7d9-2d30-4f2f-b18f-548ec2663650	groups	claim.name
f194c7d9-2d30-4f2f-b18f-548ec2663650	String	jsonType.label
61c46335-8071-4951-b873-b55200b1e041	true	introspection.token.claim
61c46335-8071-4951-b873-b55200b1e041	true	id.token.claim
61c46335-8071-4951-b873-b55200b1e041	true	access.token.claim
ee3178b3-a9e3-4e57-9990-d8e0eb49b448	false	single
ee3178b3-a9e3-4e57-9990-d8e0eb49b448	Basic	attribute.nameformat
ee3178b3-a9e3-4e57-9990-d8e0eb49b448	Role	attribute.name
82ffb219-080e-4f81-9e48-26bc8337ca2b	true	introspection.token.claim
82ffb219-080e-4f81-9e48-26bc8337ca2b	true	multivalued
82ffb219-080e-4f81-9e48-26bc8337ca2b	foo	user.attribute
82ffb219-080e-4f81-9e48-26bc8337ca2b	true	access.token.claim
82ffb219-080e-4f81-9e48-26bc8337ca2b	realm_access.roles	claim.name
82ffb219-080e-4f81-9e48-26bc8337ca2b	String	jsonType.label
9d24d35f-d9c1-458a-9552-ad84130344be	true	introspection.token.claim
9d24d35f-d9c1-458a-9552-ad84130344be	true	multivalued
9d24d35f-d9c1-458a-9552-ad84130344be	foo	user.attribute
9d24d35f-d9c1-458a-9552-ad84130344be	true	access.token.claim
9d24d35f-d9c1-458a-9552-ad84130344be	resource_access.${client_id}.roles	claim.name
9d24d35f-d9c1-458a-9552-ad84130344be	String	jsonType.label
ad721224-0a24-4ee6-a6e3-b83636dc0e40	true	access.token.claim
ad721224-0a24-4ee6-a6e3-b83636dc0e40	true	introspection.token.claim
a5aa28d6-7c6f-459d-9394-1af557228133	formatted	user.attribute.formatted
a5aa28d6-7c6f-459d-9394-1af557228133	country	user.attribute.country
a5aa28d6-7c6f-459d-9394-1af557228133	true	introspection.token.claim
a5aa28d6-7c6f-459d-9394-1af557228133	postal_code	user.attribute.postal_code
a5aa28d6-7c6f-459d-9394-1af557228133	true	userinfo.token.claim
a5aa28d6-7c6f-459d-9394-1af557228133	street	user.attribute.street
a5aa28d6-7c6f-459d-9394-1af557228133	true	id.token.claim
a5aa28d6-7c6f-459d-9394-1af557228133	region	user.attribute.region
a5aa28d6-7c6f-459d-9394-1af557228133	true	access.token.claim
a5aa28d6-7c6f-459d-9394-1af557228133	locality	user.attribute.locality
15acc04b-7253-4088-a1a9-8473e400b284	true	introspection.token.claim
15acc04b-7253-4088-a1a9-8473e400b284	true	userinfo.token.claim
15acc04b-7253-4088-a1a9-8473e400b284	phoneNumberVerified	user.attribute
15acc04b-7253-4088-a1a9-8473e400b284	true	id.token.claim
15acc04b-7253-4088-a1a9-8473e400b284	true	access.token.claim
15acc04b-7253-4088-a1a9-8473e400b284	phone_number_verified	claim.name
15acc04b-7253-4088-a1a9-8473e400b284	boolean	jsonType.label
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	true	introspection.token.claim
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	true	userinfo.token.claim
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	phoneNumber	user.attribute
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	true	id.token.claim
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	true	access.token.claim
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	phone_number	claim.name
a7863ea8-3ede-4f9d-b12d-bfb05950c84b	String	jsonType.label
259708c3-7120-46ee-add9-6acc765336f4	true	access.token.claim
259708c3-7120-46ee-add9-6acc765336f4	true	introspection.token.claim
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	true	introspection.token.claim
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	true	userinfo.token.claim
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	emailVerified	user.attribute
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	true	id.token.claim
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	true	access.token.claim
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	email_verified	claim.name
2fe3bbc9-ab0f-4bc4-b401-409fa4541ec8	boolean	jsonType.label
9abed63b-5a1e-4550-bc27-477e0a14ea0a	true	introspection.token.claim
9abed63b-5a1e-4550-bc27-477e0a14ea0a	true	userinfo.token.claim
9abed63b-5a1e-4550-bc27-477e0a14ea0a	email	user.attribute
9abed63b-5a1e-4550-bc27-477e0a14ea0a	true	id.token.claim
9abed63b-5a1e-4550-bc27-477e0a14ea0a	true	access.token.claim
9abed63b-5a1e-4550-bc27-477e0a14ea0a	email	claim.name
9abed63b-5a1e-4550-bc27-477e0a14ea0a	String	jsonType.label
63733c41-21d9-42d9-8e5a-b745fabc8733	true	introspection.token.claim
63733c41-21d9-42d9-8e5a-b745fabc8733	true	userinfo.token.claim
63733c41-21d9-42d9-8e5a-b745fabc8733	username	user.attribute
63733c41-21d9-42d9-8e5a-b745fabc8733	true	id.token.claim
63733c41-21d9-42d9-8e5a-b745fabc8733	true	access.token.claim
63733c41-21d9-42d9-8e5a-b745fabc8733	upn	claim.name
63733c41-21d9-42d9-8e5a-b745fabc8733	String	jsonType.label
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	true	introspection.token.claim
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	true	multivalued
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	true	userinfo.token.claim
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	foo	user.attribute
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	true	id.token.claim
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	true	access.token.claim
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	groups	claim.name
e9f7c3ca-0728-4fb7-846d-2a6f4ffe5b92	String	jsonType.label
ab87ad08-bba9-421e-a139-60f2ef29e321	true	id.token.claim
ab87ad08-bba9-421e-a139-60f2ef29e321	true	access.token.claim
ab87ad08-bba9-421e-a139-60f2ef29e321	true	introspection.token.claim
ab87ad08-bba9-421e-a139-60f2ef29e321	true	userinfo.token.claim
17b7832a-dde5-40ea-828f-5c48be985b07	true	introspection.token.claim
17b7832a-dde5-40ea-828f-5c48be985b07	true	userinfo.token.claim
17b7832a-dde5-40ea-828f-5c48be985b07	nickname	user.attribute
17b7832a-dde5-40ea-828f-5c48be985b07	true	id.token.claim
17b7832a-dde5-40ea-828f-5c48be985b07	true	access.token.claim
17b7832a-dde5-40ea-828f-5c48be985b07	nickname	claim.name
17b7832a-dde5-40ea-828f-5c48be985b07	String	jsonType.label
1cb5da4b-1661-4623-af9c-b6c912ef6d58	true	introspection.token.claim
1cb5da4b-1661-4623-af9c-b6c912ef6d58	true	userinfo.token.claim
1cb5da4b-1661-4623-af9c-b6c912ef6d58	gender	user.attribute
1cb5da4b-1661-4623-af9c-b6c912ef6d58	true	id.token.claim
1cb5da4b-1661-4623-af9c-b6c912ef6d58	true	access.token.claim
1cb5da4b-1661-4623-af9c-b6c912ef6d58	gender	claim.name
1cb5da4b-1661-4623-af9c-b6c912ef6d58	String	jsonType.label
30a057c2-e98f-4d59-a649-e5ad9721bacc	true	introspection.token.claim
30a057c2-e98f-4d59-a649-e5ad9721bacc	true	userinfo.token.claim
30a057c2-e98f-4d59-a649-e5ad9721bacc	updatedAt	user.attribute
30a057c2-e98f-4d59-a649-e5ad9721bacc	true	id.token.claim
30a057c2-e98f-4d59-a649-e5ad9721bacc	true	access.token.claim
30a057c2-e98f-4d59-a649-e5ad9721bacc	updated_at	claim.name
30a057c2-e98f-4d59-a649-e5ad9721bacc	long	jsonType.label
3c8ae703-d90b-4181-a00c-b81f05ff9575	true	introspection.token.claim
3c8ae703-d90b-4181-a00c-b81f05ff9575	true	userinfo.token.claim
3c8ae703-d90b-4181-a00c-b81f05ff9575	profile	user.attribute
3c8ae703-d90b-4181-a00c-b81f05ff9575	true	id.token.claim
3c8ae703-d90b-4181-a00c-b81f05ff9575	true	access.token.claim
3c8ae703-d90b-4181-a00c-b81f05ff9575	profile	claim.name
3c8ae703-d90b-4181-a00c-b81f05ff9575	String	jsonType.label
42a72efc-3db9-454f-976b-f4e750bfdaf3	true	id.token.claim
42a72efc-3db9-454f-976b-f4e750bfdaf3	true	access.token.claim
42a72efc-3db9-454f-976b-f4e750bfdaf3	true	introspection.token.claim
42a72efc-3db9-454f-976b-f4e750bfdaf3	true	userinfo.token.claim
6413f072-e1ac-4fd1-8cae-eff05552b4cf	true	introspection.token.claim
6413f072-e1ac-4fd1-8cae-eff05552b4cf	true	userinfo.token.claim
6413f072-e1ac-4fd1-8cae-eff05552b4cf	middleName	user.attribute
6413f072-e1ac-4fd1-8cae-eff05552b4cf	true	id.token.claim
6413f072-e1ac-4fd1-8cae-eff05552b4cf	true	access.token.claim
6413f072-e1ac-4fd1-8cae-eff05552b4cf	middle_name	claim.name
6413f072-e1ac-4fd1-8cae-eff05552b4cf	String	jsonType.label
6849c517-f957-4e06-b912-3d466339bd82	true	introspection.token.claim
6849c517-f957-4e06-b912-3d466339bd82	true	userinfo.token.claim
6849c517-f957-4e06-b912-3d466339bd82	locale	user.attribute
6849c517-f957-4e06-b912-3d466339bd82	true	id.token.claim
6849c517-f957-4e06-b912-3d466339bd82	true	access.token.claim
6849c517-f957-4e06-b912-3d466339bd82	locale	claim.name
6849c517-f957-4e06-b912-3d466339bd82	String	jsonType.label
91a26f7c-e959-467b-950a-782bac2a6398	true	introspection.token.claim
91a26f7c-e959-467b-950a-782bac2a6398	true	userinfo.token.claim
91a26f7c-e959-467b-950a-782bac2a6398	firstName	user.attribute
91a26f7c-e959-467b-950a-782bac2a6398	true	id.token.claim
91a26f7c-e959-467b-950a-782bac2a6398	true	access.token.claim
91a26f7c-e959-467b-950a-782bac2a6398	given_name	claim.name
91a26f7c-e959-467b-950a-782bac2a6398	String	jsonType.label
9d47e7d5-d70c-485c-b72d-801bd1ca019b	true	introspection.token.claim
9d47e7d5-d70c-485c-b72d-801bd1ca019b	true	userinfo.token.claim
9d47e7d5-d70c-485c-b72d-801bd1ca019b	lastName	user.attribute
9d47e7d5-d70c-485c-b72d-801bd1ca019b	true	id.token.claim
9d47e7d5-d70c-485c-b72d-801bd1ca019b	true	access.token.claim
9d47e7d5-d70c-485c-b72d-801bd1ca019b	family_name	claim.name
9d47e7d5-d70c-485c-b72d-801bd1ca019b	String	jsonType.label
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	true	introspection.token.claim
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	true	userinfo.token.claim
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	zoneinfo	user.attribute
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	true	id.token.claim
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	true	access.token.claim
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	zoneinfo	claim.name
a0f34ae4-d6b9-48f5-b868-ec4e86d77b67	String	jsonType.label
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	true	introspection.token.claim
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	true	userinfo.token.claim
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	website	user.attribute
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	true	id.token.claim
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	true	access.token.claim
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	website	claim.name
ac93fb45-9a62-42ca-9eee-1f0011aa59e2	String	jsonType.label
caeaf05a-063c-46d0-8f2e-1937ffe68c70	true	introspection.token.claim
caeaf05a-063c-46d0-8f2e-1937ffe68c70	true	userinfo.token.claim
caeaf05a-063c-46d0-8f2e-1937ffe68c70	birthdate	user.attribute
caeaf05a-063c-46d0-8f2e-1937ffe68c70	true	id.token.claim
caeaf05a-063c-46d0-8f2e-1937ffe68c70	true	access.token.claim
caeaf05a-063c-46d0-8f2e-1937ffe68c70	birthdate	claim.name
caeaf05a-063c-46d0-8f2e-1937ffe68c70	String	jsonType.label
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	true	introspection.token.claim
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	true	userinfo.token.claim
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	picture	user.attribute
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	true	id.token.claim
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	true	access.token.claim
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	picture	claim.name
d9f92ad6-65d3-4cb6-b9dc-5041c9ffdf08	String	jsonType.label
feeecbfd-9b7f-4735-959c-96d69e017c1e	true	introspection.token.claim
feeecbfd-9b7f-4735-959c-96d69e017c1e	true	userinfo.token.claim
feeecbfd-9b7f-4735-959c-96d69e017c1e	username	user.attribute
feeecbfd-9b7f-4735-959c-96d69e017c1e	true	id.token.claim
feeecbfd-9b7f-4735-959c-96d69e017c1e	true	access.token.claim
feeecbfd-9b7f-4735-959c-96d69e017c1e	preferred_username	claim.name
feeecbfd-9b7f-4735-959c-96d69e017c1e	String	jsonType.label
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	true	introspection.token.claim
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	true	userinfo.token.claim
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	locale	user.attribute
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	true	id.token.claim
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	true	access.token.claim
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	locale	claim.name
fa13fb23-b3ef-4a95-a118-22ee1d0bf398	String	jsonType.label
5ed0a115-3202-4ddc-83d4-272aec10f265	clientAddress	user.session.note
5ed0a115-3202-4ddc-83d4-272aec10f265	true	introspection.token.claim
5ed0a115-3202-4ddc-83d4-272aec10f265	true	id.token.claim
5ed0a115-3202-4ddc-83d4-272aec10f265	true	access.token.claim
5ed0a115-3202-4ddc-83d4-272aec10f265	clientAddress	claim.name
5ed0a115-3202-4ddc-83d4-272aec10f265	String	jsonType.label
9325a053-e91a-4e66-8634-a185460d4044	clientHost	user.session.note
9325a053-e91a-4e66-8634-a185460d4044	true	introspection.token.claim
9325a053-e91a-4e66-8634-a185460d4044	true	id.token.claim
9325a053-e91a-4e66-8634-a185460d4044	true	access.token.claim
9325a053-e91a-4e66-8634-a185460d4044	clientHost	claim.name
9325a053-e91a-4e66-8634-a185460d4044	String	jsonType.label
b8d7026d-bdf5-4134-8d13-2133112aa3d5	client_id	user.session.note
b8d7026d-bdf5-4134-8d13-2133112aa3d5	true	introspection.token.claim
b8d7026d-bdf5-4134-8d13-2133112aa3d5	true	id.token.claim
b8d7026d-bdf5-4134-8d13-2133112aa3d5	true	access.token.claim
b8d7026d-bdf5-4134-8d13-2133112aa3d5	client_id	claim.name
b8d7026d-bdf5-4134-8d13-2133112aa3d5	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
527fc094-fada-4190-a49a-737d201c5c4c	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d845197a-8f81-4129-ba71-08d654fc8706	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	565cdcb1-96fb-47be-b894-cbf762038273	b0e36e45-e2ae-4946-8a58-97087b22ccf6	f06dffd0-5e72-4db8-a229-439821c68d31	52c9a07b-f9a7-4f47-9bd7-a302725439bc	c37ac211-e332-497e-a32d-32422c4f536f	2592000	f	900	t	f	5cd9347b-daab-43ad-a533-17c4bc536bd2	0	f	0	0	c68a0ce8-ff76-4f26-9acb-8353d1fc1d56
e214324c-91eb-4614-b756-7470275d6389	60	300	300	\N	\N	\N	t	f	0	\N	csa	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e142ec1f-d516-4533-9e12-ed3e100818c8	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2f5f7e64-11b2-4008-9255-f34d2f740ba9	7b249fc6-fd70-4bbb-8bb5-829a1c97a9e2	12eb524e-b3e9-4e00-af69-d34c5ec8f73b	3d98a1f5-3683-4668-81fa-bbff95917f14	eeb7342c-b28d-4724-bc7a-1813f2339aa5	2592000	f	900	t	f	3de0b057-b9a7-4d6e-bcc1-a9e870eb6c15	0	f	0	0	78e0fef9-cfce-4b6f-86c3-8a884dfe7d34
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	527fc094-fada-4190-a49a-737d201c5c4c	
_browser_header.xContentTypeOptions	527fc094-fada-4190-a49a-737d201c5c4c	nosniff
_browser_header.referrerPolicy	527fc094-fada-4190-a49a-737d201c5c4c	no-referrer
_browser_header.xRobotsTag	527fc094-fada-4190-a49a-737d201c5c4c	none
_browser_header.xFrameOptions	527fc094-fada-4190-a49a-737d201c5c4c	SAMEORIGIN
_browser_header.contentSecurityPolicy	527fc094-fada-4190-a49a-737d201c5c4c	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	527fc094-fada-4190-a49a-737d201c5c4c	1; mode=block
_browser_header.strictTransportSecurity	527fc094-fada-4190-a49a-737d201c5c4c	max-age=31536000; includeSubDomains
bruteForceProtected	527fc094-fada-4190-a49a-737d201c5c4c	false
permanentLockout	527fc094-fada-4190-a49a-737d201c5c4c	false
maxTemporaryLockouts	527fc094-fada-4190-a49a-737d201c5c4c	0
maxFailureWaitSeconds	527fc094-fada-4190-a49a-737d201c5c4c	900
minimumQuickLoginWaitSeconds	527fc094-fada-4190-a49a-737d201c5c4c	60
waitIncrementSeconds	527fc094-fada-4190-a49a-737d201c5c4c	60
quickLoginCheckMilliSeconds	527fc094-fada-4190-a49a-737d201c5c4c	1000
maxDeltaTimeSeconds	527fc094-fada-4190-a49a-737d201c5c4c	43200
failureFactor	527fc094-fada-4190-a49a-737d201c5c4c	30
realmReusableOtpCode	527fc094-fada-4190-a49a-737d201c5c4c	false
firstBrokerLoginFlowId	527fc094-fada-4190-a49a-737d201c5c4c	a59d3638-49f5-4569-8814-395fb27e930b
displayName	527fc094-fada-4190-a49a-737d201c5c4c	Red Hat build of Keycloak
displayNameHtml	527fc094-fada-4190-a49a-737d201c5c4c	<div class="kc-logo-text"><span>Red Hat build of Keycloak</span></div>
defaultSignatureAlgorithm	527fc094-fada-4190-a49a-737d201c5c4c	RS256
offlineSessionMaxLifespanEnabled	527fc094-fada-4190-a49a-737d201c5c4c	false
offlineSessionMaxLifespan	527fc094-fada-4190-a49a-737d201c5c4c	5184000
_browser_header.contentSecurityPolicyReportOnly	e214324c-91eb-4614-b756-7470275d6389	
_browser_header.xContentTypeOptions	e214324c-91eb-4614-b756-7470275d6389	nosniff
_browser_header.referrerPolicy	e214324c-91eb-4614-b756-7470275d6389	no-referrer
_browser_header.xRobotsTag	e214324c-91eb-4614-b756-7470275d6389	none
_browser_header.xFrameOptions	e214324c-91eb-4614-b756-7470275d6389	SAMEORIGIN
_browser_header.contentSecurityPolicy	e214324c-91eb-4614-b756-7470275d6389	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e214324c-91eb-4614-b756-7470275d6389	1; mode=block
_browser_header.strictTransportSecurity	e214324c-91eb-4614-b756-7470275d6389	max-age=31536000; includeSubDomains
bruteForceProtected	e214324c-91eb-4614-b756-7470275d6389	false
permanentLockout	e214324c-91eb-4614-b756-7470275d6389	false
maxTemporaryLockouts	e214324c-91eb-4614-b756-7470275d6389	0
maxFailureWaitSeconds	e214324c-91eb-4614-b756-7470275d6389	900
minimumQuickLoginWaitSeconds	e214324c-91eb-4614-b756-7470275d6389	60
waitIncrementSeconds	e214324c-91eb-4614-b756-7470275d6389	60
quickLoginCheckMilliSeconds	e214324c-91eb-4614-b756-7470275d6389	1000
maxDeltaTimeSeconds	e214324c-91eb-4614-b756-7470275d6389	43200
failureFactor	e214324c-91eb-4614-b756-7470275d6389	30
realmReusableOtpCode	e214324c-91eb-4614-b756-7470275d6389	false
defaultSignatureAlgorithm	e214324c-91eb-4614-b756-7470275d6389	RS256
offlineSessionMaxLifespanEnabled	e214324c-91eb-4614-b756-7470275d6389	false
offlineSessionMaxLifespan	e214324c-91eb-4614-b756-7470275d6389	5184000
clientSessionIdleTimeout	e214324c-91eb-4614-b756-7470275d6389	0
clientSessionMaxLifespan	e214324c-91eb-4614-b756-7470275d6389	0
clientOfflineSessionIdleTimeout	e214324c-91eb-4614-b756-7470275d6389	0
clientOfflineSessionMaxLifespan	e214324c-91eb-4614-b756-7470275d6389	0
actionTokenGeneratedByAdminLifespan	e214324c-91eb-4614-b756-7470275d6389	43200
actionTokenGeneratedByUserLifespan	e214324c-91eb-4614-b756-7470275d6389	300
oauth2DeviceCodeLifespan	e214324c-91eb-4614-b756-7470275d6389	600
oauth2DevicePollingInterval	e214324c-91eb-4614-b756-7470275d6389	5
webAuthnPolicyRpEntityName	e214324c-91eb-4614-b756-7470275d6389	keycloak
webAuthnPolicySignatureAlgorithms	e214324c-91eb-4614-b756-7470275d6389	ES256
webAuthnPolicyRpId	e214324c-91eb-4614-b756-7470275d6389	
webAuthnPolicyAttestationConveyancePreference	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyAuthenticatorAttachment	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyRequireResidentKey	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyUserVerificationRequirement	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyCreateTimeout	e214324c-91eb-4614-b756-7470275d6389	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e214324c-91eb-4614-b756-7470275d6389	false
webAuthnPolicyRpEntityNamePasswordless	e214324c-91eb-4614-b756-7470275d6389	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e214324c-91eb-4614-b756-7470275d6389	ES256
webAuthnPolicyRpIdPasswordless	e214324c-91eb-4614-b756-7470275d6389	
webAuthnPolicyAttestationConveyancePreferencePasswordless	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyRequireResidentKeyPasswordless	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e214324c-91eb-4614-b756-7470275d6389	not specified
webAuthnPolicyCreateTimeoutPasswordless	e214324c-91eb-4614-b756-7470275d6389	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e214324c-91eb-4614-b756-7470275d6389	false
cibaBackchannelTokenDeliveryMode	e214324c-91eb-4614-b756-7470275d6389	poll
cibaExpiresIn	e214324c-91eb-4614-b756-7470275d6389	120
cibaInterval	e214324c-91eb-4614-b756-7470275d6389	5
cibaAuthRequestedUserHint	e214324c-91eb-4614-b756-7470275d6389	login_hint
parRequestUriLifespan	e214324c-91eb-4614-b756-7470275d6389	60
firstBrokerLoginFlowId	e214324c-91eb-4614-b756-7470275d6389	316e5e1a-a8cd-41d0-9142-1c72332eced3
client-policies.profiles	e214324c-91eb-4614-b756-7470275d6389	{"profiles":[]}
client-policies.policies	e214324c-91eb-4614-b756-7470275d6389	{"policies":[]}
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
527fc094-fada-4190-a49a-737d201c5c4c	jboss-logging
e214324c-91eb-4614-b756-7470275d6389	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	527fc094-fada-4190-a49a-737d201c5c4c
password	password	t	t	e214324c-91eb-4614-b756-7470275d6389
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.redirect_uris (client_id, value) FROM stdin;
cc1e7c6d-5c38-4c39-b1ea-e7c92013972c	/realms/master/account/*
3c3eab9f-45df-4b5f-bf9d-b33371593045	/realms/master/account/*
8152e404-de3a-4404-a139-aa7feb9dba14	/admin/master/console/*
31e21bd5-5ea5-4b69-b659-a9e29cfe1704	/realms/csa/account/*
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	/realms/csa/account/*
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	/admin/csa/console/*
1d401474-10ce-4b15-b372-2884e64a3da2	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
54cbaa17-1656-41a8-b39c-d425d384ca80	VERIFY_EMAIL	Verify Email	527fc094-fada-4190-a49a-737d201c5c4c	t	f	VERIFY_EMAIL	50
4fd70a8a-697d-4c31-b79c-e44ac2ec36c4	UPDATE_PROFILE	Update Profile	527fc094-fada-4190-a49a-737d201c5c4c	t	f	UPDATE_PROFILE	40
7bfaceaf-722a-4e4d-967b-f4408a44e392	CONFIGURE_TOTP	Configure OTP	527fc094-fada-4190-a49a-737d201c5c4c	t	f	CONFIGURE_TOTP	10
1c186bf6-d8f8-4d91-8e80-00984f39d1c8	UPDATE_PASSWORD	Update Password	527fc094-fada-4190-a49a-737d201c5c4c	t	f	UPDATE_PASSWORD	30
baadf6d5-71e9-4324-98da-0a62a086fe7f	TERMS_AND_CONDITIONS	Terms and Conditions	527fc094-fada-4190-a49a-737d201c5c4c	f	f	TERMS_AND_CONDITIONS	20
ec4f76ac-c80b-4edb-b598-952ead5c2196	delete_account	Delete Account	527fc094-fada-4190-a49a-737d201c5c4c	f	f	delete_account	60
1357cf53-0920-4141-b6b2-c13001a5daeb	delete_credential	Delete Credential	527fc094-fada-4190-a49a-737d201c5c4c	t	f	delete_credential	100
b426b054-de36-4248-b5c6-9fca77011c5b	update_user_locale	Update User Locale	527fc094-fada-4190-a49a-737d201c5c4c	t	f	update_user_locale	1000
949b70f7-7342-4eb7-8465-25e51faf4f57	webauthn-register	Webauthn Register	527fc094-fada-4190-a49a-737d201c5c4c	t	f	webauthn-register	70
badd900a-edd0-470e-9822-19f8199e2f6e	webauthn-register-passwordless	Webauthn Register Passwordless	527fc094-fada-4190-a49a-737d201c5c4c	t	f	webauthn-register-passwordless	80
c6d8cab2-7e48-4fe0-ab77-f7ee2405991a	VERIFY_PROFILE	Verify Profile	527fc094-fada-4190-a49a-737d201c5c4c	t	f	VERIFY_PROFILE	90
92980334-9fd3-46de-be9c-3cdc3072754e	CONFIGURE_TOTP	Configure OTP	e214324c-91eb-4614-b756-7470275d6389	t	f	CONFIGURE_TOTP	10
3d98aba1-593f-46ee-9bb4-25561db523cb	TERMS_AND_CONDITIONS	Terms and Conditions	e214324c-91eb-4614-b756-7470275d6389	f	f	TERMS_AND_CONDITIONS	20
446411f9-935b-4992-8105-5b4ab8e75dfd	UPDATE_PASSWORD	Update Password	e214324c-91eb-4614-b756-7470275d6389	t	f	UPDATE_PASSWORD	30
a1b28772-eb3a-4b1c-9511-60b7ac05f71a	UPDATE_PROFILE	Update Profile	e214324c-91eb-4614-b756-7470275d6389	t	f	UPDATE_PROFILE	40
2e6e4c39-1ffe-4251-ab19-a1727d538872	VERIFY_EMAIL	Verify Email	e214324c-91eb-4614-b756-7470275d6389	t	f	VERIFY_EMAIL	50
29ed8f7e-9e8c-428f-bdb8-3907451b9c4f	delete_account	Delete Account	e214324c-91eb-4614-b756-7470275d6389	f	f	delete_account	60
c25a0454-e5da-4d81-baff-f6b702dd2f69	webauthn-register	Webauthn Register	e214324c-91eb-4614-b756-7470275d6389	t	f	webauthn-register	70
1a036ee2-ff84-4ed4-b8ac-3668495815ca	webauthn-register-passwordless	Webauthn Register Passwordless	e214324c-91eb-4614-b756-7470275d6389	t	f	webauthn-register-passwordless	80
477c53a8-545c-4ad4-99f1-73cc89a01cf0	VERIFY_PROFILE	Verify Profile	e214324c-91eb-4614-b756-7470275d6389	t	f	VERIFY_PROFILE	90
15267197-4721-491c-84c3-e13e1823a21b	delete_credential	Delete Credential	e214324c-91eb-4614-b756-7470275d6389	t	f	delete_credential	100
1bca0b46-b772-4ab5-8a46-02569bd07ab3	update_user_locale	Update User Locale	e214324c-91eb-4614-b756-7470275d6389	t	f	update_user_locale	1000
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
3c3eab9f-45df-4b5f-bf9d-b33371593045	d9818237-2380-48cb-97b6-22edfef4616f
3c3eab9f-45df-4b5f-bf9d-b33371593045	b3b23b42-e408-4938-b8e5-e51aef7cd520
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	489babdc-82cc-410f-954d-ff525a1af70f
dd7808d3-79f2-469c-8bbe-0cf915ac5bf5	871278fb-47bf-442a-98a4-d47b60768a66
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
d26108fc-8b27-44f7-b0c0-043ee4106287	megusta@lagasolina.com	megusta@lagasolina.com	t	t	\N	Jonathan 	Perrera	e214324c-91eb-4614-b756-7470275d6389	garbanzo	1724166450382	\N	0
ad98ec1e-aef3-4406-9fe4-303945b69857	garbanzo@comida.com	garbanzo@comida.com	t	t	\N	Melo 	Invento	e214324c-91eb-4614-b756-7470275d6389	garbanzo1	1724166404325	\N	0
3e50cc9d-9922-4361-90fb-f7a953672011	hombredelsaco@terror.com	hombredelsaco@terror.com	t	t	\N	Leticia	Sabater	e214324c-91eb-4614-b756-7470275d6389	newgarbanzo	1724228475560	\N	0
ba29ced6-e2b1-4d96-9f26-bd9f8002e305	\N	23218569-4845-48f6-a8c3-422922674f78	f	t	\N	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	admin	1724240930758	\N	0
d034745b-2f08-4dba-b5c8-98ef13d520f1	\N	acd31808-82cc-46ff-a7fd-4953f891df3f	f	t	\N	\N	\N	527fc094-fada-4190-a49a-737d201c5c4c	service-account-admin-cli	1724777671626	3d5cb514-7f35-4402-99ea-4f9e55f8f6b8	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
19a27783-789c-4cc2-bd4f-08b43279f666	d26108fc-8b27-44f7-b0c0-043ee4106287
9ab58f70-5d35-49a7-847f-a35bca46eae4	ad98ec1e-aef3-4406-9fe4-303945b69857
19a27783-789c-4cc2-bd4f-08b43279f666	3e50cc9d-9922-4361-90fb-f7a953672011
9ab58f70-5d35-49a7-847f-a35bca46eae4	3e50cc9d-9922-4361-90fb-f7a953672011
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	d26108fc-8b27-44f7-b0c0-043ee4106287
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	ad98ec1e-aef3-4406-9fe4-303945b69857
981e392d-13ef-4996-a0f8-1002a184c8b1	3e50cc9d-9922-4361-90fb-f7a953672011
78e0fef9-cfce-4b6f-86c3-8a884dfe7d34	3e50cc9d-9922-4361-90fb-f7a953672011
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	ba29ced6-e2b1-4d96-9f26-bd9f8002e305
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	ba29ced6-e2b1-4d96-9f26-bd9f8002e305
c68a0ce8-ff76-4f26-9acb-8353d1fc1d56	d034745b-2f08-4dba-b5c8-98ef13d520f1
d2a64e5a-0220-47b9-9fb5-2d06fbe582c6	d034745b-2f08-4dba-b5c8-98ef13d520f1
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: testuser
--

COPY public.web_origins (client_id, value) FROM stdin;
8152e404-de3a-4404-a139-aa7feb9dba14	+
cb1a02c4-91e7-44bb-b9e3-4c41b549c3d8	+
1d401474-10ce-4b15-b372-2884e64a3da2	*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: testuser
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: testuser
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

