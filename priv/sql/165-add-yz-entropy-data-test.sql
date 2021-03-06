BEGIN;

-- Insert new tests for 2.0.7+ needs
WITH s as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('yz_entropy_data', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_entropy_data', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, s.id FROM projects, s
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

-- Insert new tests for 2.1.2+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_entropy_data', 'centos-5-64', '{2,1,2}'),
       ('yz_entropy_data', 'centos-6-64', '{2,1,2}'),
       ('yz_entropy_data', 'fedora-17-64', '{2,1,2}'),
       ('yz_entropy_data', 'freebsd-9-64', '{2,1,2}'),
       ('yz_entropy_data', 'osx-64', '{2,1,2}'),
       ('yz_entropy_data', 'solaris-10u9-64', '{2,1,2}'),
       ('yz_entropy_data', 'ubuntu-1004-64', '{2,1,2}'),
       ('yz_entropy_data', 'ubuntu-1204-64', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
