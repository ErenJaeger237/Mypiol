import { Stack } from 'expo-router';
import { useColorScheme } from 'react-native';
import { StatusBar } from 'expo-status-bar';
import { Colors } from '../constants/Colors';

import { AuthProvider } from '../context/AuthContext';

export default function RootLayout() {
    return (
        <AuthProvider>
            <RootLayoutNav />
        </AuthProvider>
    );
}

function RootLayoutNav() {
    const colorScheme = useColorScheme();
    const theme = Colors[colorScheme ?? 'light'];

    return (
        <>
            <StatusBar style={colorScheme === 'dark' ? 'light' : 'dark'} />
            <Stack
                screenOptions={{
                    headerStyle: {
                        backgroundColor: theme.background,
                    },
                    headerTintColor: theme.text,
                    headerTitleStyle: {
                        fontWeight: 'bold',
                    },
                    contentStyle: {
                        backgroundColor: theme.background,
                    },
                }}
            >
                <Stack.Screen
                    name="index"
                    options={{
                        title: 'Discover',
                        headerLargeTitle: true,
                        headerShadowVisible: false,
                        headerStyle: { backgroundColor: theme.background },
                    }}
                />
                <Stack.Screen
                    name="property/[id]"
                    options={{
                        title: '',
                        headerTransparent: true,
                        headerTintColor: '#fff',
                        presentation: 'modal',
                    }}
                />
            </Stack>
        </>
    );
}
