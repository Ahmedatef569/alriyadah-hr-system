// Supabase Configuration File
// HR Management System Database Configuration

// IMPORTANT: Replace these with your actual Supabase credentials
// For production, use environment variables or a secure configuration system
// Get these values from your Supabase project: Project Settings > API

const SUPABASE_URL = 'https://jomzhsbkofcoocqhqsol.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpvbXpoc2Jrb2Zjb29jcWhxc29sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4MzU5MzYsImV4cCI6MjA2NjQxMTkzNn0.YhP1cyQXwEXxcLkz22eEc5olCoSIiYccLmqoCjS8Dog';

// TODO: For production deployment, replace the above with:
// const SUPABASE_URL = process.env.SUPABASE_URL || 'your_fallback_url';
// const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY || 'your_fallback_key';

// Wait for Supabase to be available and create client
let supabaseClient = null;

// Function to wait for Supabase to be available
async function waitForSupabase() {
    return new Promise((resolve) => {
        if (window.supabase) {
            resolve(window.supabase);
        } else {
            const checkSupabase = () => {
                if (window.supabase) {
                    resolve(window.supabase);
                } else {
                    setTimeout(checkSupabase, 10);
                }
            };
            checkSupabase();
        }
    });
}

// Initialize function
async function initializeSupabase() {
    if (!supabaseClient) {
        const supabaseLib = await waitForSupabase();
        const { createClient } = supabaseLib;
        supabaseClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
    }
    return supabaseClient;
}

// Export the client
export const supabase = {
    async from(table) {
        const client = await initializeSupabase();
        return client.from(table);
    }
};

// Database helper functions
export const dbHelpers = {
    // User operations
    async getUserByCredentials(email, password) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('users')
            .select('*')
            .eq('email', email)
            .eq('password', password)
            .single();
        return { data, error };
    },

    // Employee operations
    async getAllEmployees() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('employees')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async addEmployee(employee) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('employees')
            .insert([employee])
            .select()
            .single();
        return { data, error };
    },

    async updateEmployee(id, updates) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('employees')
            .update(updates)
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deleteEmployee(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('employees')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    // Leave operations
    async getAllLeaves() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async addLeave(leaveData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .insert([leaveData])
            .select()
            .single();
        return { data, error };
    },

    // Other operations
    async getAllExcuses() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('excuses')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async getAllOvertime() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('overtime')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async getAllPenalties() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('penalties')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async getAllSalaries() {
        // Check if current user is admin_1 (limited access)
        if (typeof window !== 'undefined' && window.currentUserRole === 'admin_1') {
            return { data: [], error: { message: 'Access denied: Insufficient permissions' } };
        }

        const client = await initializeSupabase();
        const { data, error } = await client
            .from('salary_details')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async getAllPayroll() {
        // Check if current user is admin_1 (limited access)
        if (typeof window !== 'undefined' && window.currentUserRole === 'admin_1') {
            return { data: [], error: { message: 'Access denied: Insufficient permissions' } };
        }

        const client = await initializeSupabase();
        const { data, error } = await client
            .from('payroll')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    // Leave operations
    async addLeaveRequest(leaveData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .insert([leaveData])
            .select()
            .single();
        return { data, error };
    },

    async updateLeaveStatus(id, status) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .update({ status, updated_at: new Date().toISOString() })
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deleteLeaveRequest(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    async getAllLeaveRequests() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('leaves')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    // Excuse operations
    async addExcuseRequest(excuseData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('excuses')
            .insert([excuseData])
            .select()
            .single();
        return { data, error };
    },

    async updateExcuseStatus(id, status) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('excuses')
            .update({ status, updated_at: new Date().toISOString() })
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deleteExcuseRequest(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('excuses')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    async getAllExcuseRequests() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('excuses')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    // Overtime operations
    async addOvertimeRequest(overtimeData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('overtime')
            .insert([overtimeData])
            .select()
            .single();
        return { data, error };
    },

    async updateOvertimeStatus(id, status) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('overtime')
            .update({ status, updated_at: new Date().toISOString() })
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deleteOvertimeRequest(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('overtime')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    async getAllOvertimeRequests() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('overtime')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    // Penalty operations
    async addPenalty(penaltyData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('penalties')
            .insert([penaltyData])
            .select()
            .single();
        return { data, error };
    },

    async getAllPenalties() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('penalties')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    async deletePenalty(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('penalties')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    // Salary operations
    async addSalary(salaryData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('salary_details')
            .insert([salaryData])
            .select()
            .single();
        return { data, error };
    },

    async updateSalary(id, updates) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('salary_details')
            .update(updates)
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deleteSalary(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('salary_details')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    async getAllSalaryDetails() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('salary_details')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    },

    // Payroll operations
    async addPayroll(payrollData) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('payroll')
            .insert([payrollData])
            .select()
            .single();
        return { data, error };
    },

    async updatePayroll(id, updates) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('payroll')
            .update(updates)
            .eq('id', id)
            .select()
            .single();
        return { data, error };
    },

    async deletePayroll(id) {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('payroll')
            .delete()
            .eq('id', id);
        return { data, error };
    },

    async getAllPayroll() {
        const client = await initializeSupabase();
        const { data, error } = await client
            .from('payroll')
            .select('*')
            .order('created_at', { ascending: false });
        return { data, error };
    }
};

// Utility functions
export const utils = {
    // Test database connection
    async testConnection() {
        try {
            const client = await initializeSupabase();
            const { data, error } = await client
                .from('employees')
                .select('count')
                .limit(1);

            if (error) {
                console.error('Database connection failed:', error);
                return { success: false, error };
            }

            console.log('Database connection successful');
            return { success: true };
        } catch (error) {
            console.error('Database connection error:', error);
            return { success: false, error };
        }
    }
};
