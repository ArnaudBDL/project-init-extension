import {
    RemoteServerArchitecture
} from '../models/project-profile';

export interface RemoteServerArchitectureOption {
    key: RemoteServerArchitecture;
    label: string;
    description: string;
}

export const REMOTE_SERVER_ARCHITECTURES:
readonly RemoteServerArchitectureOption[] = [
    {
        key: 'monolith',
        label: 'Remote monolith',
        description:
            'Generate one remote server application.'
    },
    {
        key: 'microservices',
        label: 'Microservices',
        description:
            'Generate independently identified domain services.'
    },
    {
        key: 'none',
        label: 'None',
        description:
            'Do not generate a remote server architecture.'
    }
];

export function getRemoteServerArchitectureLabel(
    architecture: RemoteServerArchitecture
): string {
    return REMOTE_SERVER_ARCHITECTURES.find(
        option => option.key === architecture
    )?.label ?? architecture;
}