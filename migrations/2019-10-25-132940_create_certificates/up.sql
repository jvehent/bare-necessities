CREATE TABLE certificates(
    id                          serial primary key,
    sha1_fingerprint            text NOT NULL,
    sha256_fingerprint          text NOT NULL,
    sha256_spki                 text NOT NULL,
    sha256_subject_spki         text NOT NULL,
    pkp_sha256                  text NOT NULL,
    serial_number               text NULL,
    version                     integer NULL,
    domains                     text NULL,
    subject                     jsonb NULL,
    issuer                      jsonb NULL,
    is_ca                       bool NULL,
    not_valid_before            timestamp NULL,
    not_valid_after             timestamp NULL,
    first_seen                  timestamp NULL,
    last_seen                   timestamp NULL,
    key_alg                     text NULL,
    key                         jsonb NULL,
    x509_basicConstraints       text NULL,
    x509_crlDistributionPoints  jsonb NULL,
    x509_extendedKeyUsage       jsonb NULL,
    x509_extendedKeyUsageOID    jsonb NULL,
    x509_authorityKeyIdentifier text NULL,
    x509_subjectKeyIdentifier   text NULL,
    x509_keyUsage               jsonb NULL,
    x509_certificatePolicies    jsonb NULL,
    x509_authorityInfoAccess    text NULL,
    x509_subjectAltName         jsonb NULL,
    x509_issuerAltName          text NULL,
    is_name_constrained         bool NULL,
    permitted_names             jsonb NULL,
    signature_algo              text NULL,
    in_ubuntu_root_store        bool NULL,
    in_mozilla_root_store       bool NULL,
    in_microsoft_root_store     bool NULL,
    in_apple_root_store         bool NULL,
    in_android_root_store       bool NULL,
    is_revoked                  bool NULL,
    revoked_at                  timestamp NULL,
    raw_cert                    text NOT NULL,
    permitted_dns_domains       text[] NOT NULL DEFAULT '{}',
    permitted_ip_addresses      text[] NOT NULL DEFAULT '{}',
    excluded_dns_domains        text[] NOT NULL DEFAULT '{}',
    excluded_ip_addresses       text[] NOT NULL DEFAULT '{}',
    is_technically_constrained  bool NOT NULL DEFAULT false,
    cisco_umbrella_rank         integer NOT NULL DEFAULT 2147483647,
    mozillaPolicyV2_5           jsonb NULL
);
CREATE INDEX certificates_sha256_fingerprint_idx ON certificates(sha256_fingerprint);
CREATE INDEX certificates_subject_idx ON certificates(subject);
CREATE INDEX certificates_cisco_umbrella_rank ON certificates(cisco_umbrella_rank);
CREATE INDEX certificates_first_seen_idx ON certificates(first_seen);
CREATE INDEX certificates_last_seen_idx ON certificates(last_seen);
ALTER TABLE certificates ADD CONSTRAINT certificates_unique_sha256_fingerprint UNIQUE (sha256_fingerprint);