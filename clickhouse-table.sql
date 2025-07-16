CREATE TABLE admin_users (
    tenant_id String,
    id String,
    username Nullable (String),
    role_id Nullable (String),
    site_id Nullable (Int32),
    email Nullable (String),
    first_name_english Nullable (String),
    first_name_arabic Nullable (String),
    last_name_english Nullable (String),
    last_name_arabic Nullable (String),
    mobile_number Nullable (String),
    is_active Nullable (Int8),
    created_at Nullable (DateTime),
    updated_at Nullable (DateTime),
    deleted_at Nullable (DateTime),
    created_by Nullable (String),
    updated_by Nullable (String),
    deleted_by Nullable (String)
) ENGINE = MergeTree
ORDER BY (tenant_id, id);