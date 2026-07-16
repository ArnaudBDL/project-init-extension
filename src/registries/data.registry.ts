export interface DataService {
    key: string;
    label: string;
}

export const DATABASES: readonly DataService[] = [
    {
        key: 'postgresql',
        label: 'PostgreSQL'
    },
    {
        key: 'mysql',
        label: 'MySQL'
    },
    {
        key: 'mariadb',
        label: 'MariaDB'
    },
    {
        key: 'sqlite',
        label: 'SQLite'
    },
    {
        key: 'sql-server',
        label: 'SQL Server'
    },
    {
        key: 'mongodb',
        label: 'MongoDB'
    },
    {
        key: 'redis',
        label: 'Redis'
    },
    {
        key: 'clickhouse',
        label: 'ClickHouse'
    }
];

export const SEARCH_ENGINES: readonly DataService[] = [
    {
        key: 'elasticsearch',
        label: 'Elasticsearch'
    },
    {
        key: 'opensearch',
        label: 'OpenSearch'
    },
    {
        key: 'meilisearch',
        label: 'Meilisearch'
    },
    {
        key: 'typesense',
        label: 'Typesense'
    },
    {
        key: 'algolia',
        label: 'Algolia'
    }
];

export function getDataServiceLabels(
    selectedKeys: readonly string[],
    registry: readonly DataService[]
): string {
    if (selectedKeys.length === 0) {
        return 'None';
    }

    return selectedKeys
        .map(
            key => registry.find(
                service => service.key === key
            )?.label ?? key
        )
        .join(', ');
}