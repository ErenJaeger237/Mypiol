import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput, TouchableOpacity, useColorScheme, KeyboardAvoidingView, Platform, ScrollView } from 'react-native';
import { Link, useRouter } from 'expo-router';
import { Colors } from '../../constants/Colors';
import { useAuth } from '../../context/AuthContext';
import { Ionicons } from '@expo/vector-icons';

type Role = 'tenant' | 'owner';

export default function SignUp() {
    const colorScheme = useColorScheme();
    const theme = Colors[colorScheme ?? 'light'];
    const { signIn } = useAuth();

    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [role, setRole] = useState<Role>('tenant');

    const handleSignUp = () => {
        if (email && password) {
            signIn(email, role);
        }
    };

    return (
        <KeyboardAvoidingView
            behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
            style={[styles.container, { backgroundColor: theme.background }]}
        >
            <ScrollView contentContainerStyle={styles.scrollContent} showsVerticalScrollIndicator={false}>
                <View style={styles.header}>
                    <Text style={[styles.title, { color: theme.text }]}>Create Account</Text>
                    <Text style={[styles.subtitle, { color: theme.secondary }]}>Join our exclusive community</Text>
                </View>

                {/* Role Selection */}
                <View style={styles.roleContainer}>
                    <Text style={[styles.label, { color: theme.text }]}>I am a...</Text>
                    <View style={styles.roleSelector}>
                        <TouchableOpacity
                            style={[
                                styles.roleOption,
                                role === 'tenant' && { backgroundColor: theme.primary, borderColor: theme.primary },
                                { borderColor: theme.border, backgroundColor: role === 'tenant' ? theme.primary : 'transparent' }
                            ]}
                            onPress={() => setRole('tenant')}
                        >
                            <Ionicons name="search" size={24} color={role === 'tenant' ? 'white' : theme.secondary} />
                            <Text style={[styles.roleText, { color: role === 'tenant' ? 'white' : theme.secondary }]}>Tenant</Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                            style={[
                                styles.roleOption,
                                role === 'owner' && { backgroundColor: theme.primary, borderColor: theme.primary },
                                { borderColor: theme.border, backgroundColor: role === 'owner' ? theme.primary : 'transparent' }
                            ]}
                            onPress={() => setRole('owner')}
                        >
                            <Ionicons name="key" size={24} color={role === 'owner' ? 'white' : theme.secondary} />
                            <Text style={[styles.roleText, { color: role === 'owner' ? 'white' : theme.secondary }]}>House Owner</Text>
                        </TouchableOpacity>
                    </View>
                </View>

                <View style={styles.form}>
                    <View style={[styles.inputContainer, { backgroundColor: theme.card, borderColor: theme.border }]}>
                        <Ionicons name="person-outline" size={20} color={theme.secondary} style={styles.inputIcon} />
                        <TextInput
                            placeholder="Full Name"
                            placeholderTextColor={theme.secondary}
                            style={[styles.input, { color: theme.text }]}
                            value={name}
                            onChangeText={setName}
                        />
                    </View>

                    <View style={[styles.inputContainer, { backgroundColor: theme.card, borderColor: theme.border }]}>
                        <Ionicons name="mail-outline" size={20} color={theme.secondary} style={styles.inputIcon} />
                        <TextInput
                            placeholder="Email"
                            placeholderTextColor={theme.secondary}
                            style={[styles.input, { color: theme.text }]}
                            value={email}
                            onChangeText={setEmail}
                            autoCapitalize="none"
                        />
                    </View>

                    <View style={[styles.inputContainer, { backgroundColor: theme.card, borderColor: theme.border }]}>
                        <Ionicons name="lock-closed-outline" size={20} color={theme.secondary} style={styles.inputIcon} />
                        <TextInput
                            placeholder="Password"
                            placeholderTextColor={theme.secondary}
                            style={[styles.input, { color: theme.text }]}
                            value={password}
                            onChangeText={setPassword}
                            secureTextEntry
                        />
                    </View>

                    <TouchableOpacity
                        style={[styles.button, { backgroundColor: theme.primary }]}
                        onPress={handleSignUp}
                    >
                        <Text style={styles.buttonText}>Sign Up</Text>
                    </TouchableOpacity>

                    <Link href="/auth/login" asChild>
                        <TouchableOpacity style={styles.linkButton}>
                            <Text style={[styles.linkText, { color: theme.secondary }]}>
                                Already have an account? <Text style={{ color: theme.primary, fontWeight: 'bold' }}>Sign In</Text>
                            </Text>
                        </TouchableOpacity>
                    </Link>
                </View>
            </ScrollView>
        </KeyboardAvoidingView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    scrollContent: {
        flexGrow: 1,
        justifyContent: 'center',
        padding: 24,
    },
    header: {
        marginBottom: 32,
    },
    title: {
        fontSize: 32,
        fontWeight: 'bold',
    },
    subtitle: {
        fontSize: 16,
        marginTop: 8,
    },
    label: {
        fontSize: 16,
        fontWeight: '600',
        marginBottom: 12,
    },
    roleContainer: {
        marginBottom: 24,
    },
    roleSelector: {
        flexDirection: 'row',
        gap: 16,
    },
    roleOption: {
        flex: 1,
        height: 100,
        borderWidth: 1,
        borderRadius: 16,
        justifyContent: 'center',
        alignItems: 'center',
        gap: 8,
    },
    roleText: {
        fontSize: 16,
        fontWeight: '600',
    },
    form: {
        gap: 16,
    },
    inputContainer: {
        flexDirection: 'row',
        alignItems: 'center',
        borderWidth: 1,
        borderRadius: 12,
        paddingHorizontal: 16,
        paddingVertical: 12,
        height: 56,
    },
    inputIcon: {
        marginRight: 12,
    },
    input: {
        flex: 1,
        fontSize: 16,
    },
    button: {
        height: 56,
        borderRadius: 12,
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 16,
        shadowColor: "#000",
        shadowOffset: {
            width: 0,
            height: 4,
        },
        shadowOpacity: 0.3,
        shadowRadius: 4.65,
        elevation: 8,
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
    linkButton: {
        alignItems: 'center',
        marginTop: 16,
    },
    linkText: {
        fontSize: 14,
    },
});
