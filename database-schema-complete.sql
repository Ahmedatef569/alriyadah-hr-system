-- HR Management System Database Schema - Complete Version
-- Run this script in your Supabase SQL editor for new projects
-- This version includes all fixes and is ready for deployment

-- Create users table for authentication
-- Note: id field corresponds to 'code' in the UI
-- name is optional (null for admin-only users)
CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT,
    role TEXT DEFAULT 'admin',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create employees table
CREATE TABLE IF NOT EXISTS employees (
    id TEXT PRIMARY KEY,
    full_name TEXT NOT NULL,
    gender TEXT,
    hiring_date DATE,
    position TEXT,
    department TEXT,
    dob DATE,
    phone TEXT,
    email TEXT UNIQUE,
    address TEXT,
    id_number TEXT,
    social_insurance TEXT,
    status TEXT DEFAULT 'Active',
    military_status TEXT,
    level TEXT,
    direct_manager TEXT,
    resign_date DATE,
    marital_status TEXT,
    faculty TEXT,
    grad_year INTEGER,
    annual_leave_balance INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create leaves table
CREATE TABLE IF NOT EXISTS leaves (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    days DECIMAL(3,1) NOT NULL,
    type TEXT NOT NULL,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create excuses table
CREATE TABLE IF NOT EXISTS excuses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    date DATE NOT NULL,
    type TEXT NOT NULL,
    start_time TEXT,
    end_time TEXT,
    reason TEXT,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create overtime table
CREATE TABLE IF NOT EXISTS overtime (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    date DATE NOT NULL,
    start_time TEXT,
    end_time TEXT,
    hours INTEGER,
    reason TEXT,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create penalties table
CREATE TABLE IF NOT EXISTS penalties (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    date DATE NOT NULL,
    days DECIMAL(3,1) NOT NULL,
    reason TEXT,
    status TEXT DEFAULT 'Pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create salary_details table (NOT salaries - this is important!)
CREATE TABLE IF NOT EXISTS salary_details (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    total_salary DECIMAL(10,2),
    basic_salary DECIMAL(10,2),
    fixed_allowance DECIMAL(10,2),
    fixed_deduction DECIMAL(10,2),
    bank_name TEXT,
    account_number TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create payroll table
CREATE TABLE IF NOT EXISTS payroll (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id TEXT REFERENCES employees(id) ON DELETE CASCADE,
    employee_name TEXT,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    basic_salary DECIMAL(10,2),
    allowances DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);
CREATE INDEX IF NOT EXISTS idx_employees_email ON employees(email);
CREATE INDEX IF NOT EXISTS idx_employees_status ON employees(status);
CREATE INDEX IF NOT EXISTS idx_leaves_employee_id ON leaves(employee_id);
CREATE INDEX IF NOT EXISTS idx_leaves_status ON leaves(status);
CREATE INDEX IF NOT EXISTS idx_excuses_employee_id ON excuses(employee_id);
CREATE INDEX IF NOT EXISTS idx_overtime_employee_id ON overtime(employee_id);
CREATE INDEX IF NOT EXISTS idx_penalties_employee_id ON penalties(employee_id);
CREATE INDEX IF NOT EXISTS idx_salary_details_employee_id ON salary_details(employee_id);
CREATE INDEX IF NOT EXISTS idx_payroll_employee_id ON payroll(employee_id);
CREATE INDEX IF NOT EXISTS idx_payroll_month_year ON payroll(month, year);

-- Enable Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE employees ENABLE ROW LEVEL SECURITY;
ALTER TABLE leaves ENABLE ROW LEVEL SECURITY;
ALTER TABLE excuses ENABLE ROW LEVEL SECURITY;
ALTER TABLE overtime ENABLE ROW LEVEL SECURITY;
ALTER TABLE penalties ENABLE ROW LEVEL SECURITY;
ALTER TABLE salary_details ENABLE ROW LEVEL SECURITY;
ALTER TABLE payroll ENABLE ROW LEVEL SECURITY;

-- Create RLS policies (permissive for custom authentication system)
-- Allow all operations - your system handles authentication via users table
CREATE POLICY "Allow all operations" ON users FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON employees FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON leaves FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON excuses FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON overtime FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON penalties FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON salary_details FOR ALL USING (true);
CREATE POLICY "Allow all operations" ON payroll FOR ALL USING (true);

-- Insert default admin employee (optional)
INSERT INTO employees (
    id, full_name, email, status, level, position, department, hiring_date
) VALUES (
    'ADMIN001', 'System Administrator', 'admin@company.com', 'Active', 'Admin', 'System Administrator', 'IT', CURRENT_DATE
) ON CONFLICT (id) DO NOTHING;

-- Insert default users for authentication
-- Admin user (no name = admin-only user)
-- Admin_1 user (limited admin with restricted access to salary/payroll)
-- Manager and Employee users (with names, can be linked to employees later)
INSERT INTO users (id, email, password, name, role) VALUES
    ('ADMIN001', 'admin@company.com', 'admin123', NULL, 'admin'),
    ('ADM1001', 'admin1@company.com', 'admin123', 'Limited Admin', 'admin_1'),
    ('MGR001', 'manager@company.com', 'user123', 'Test Manager', 'manager'),
    ('EMP001', 'employee@company.com', 'user123', 'Test Employee', 'employee')
ON CONFLICT (id) DO NOTHING;

-- Create sample employees for testing (optional)
INSERT INTO employees (
    id, full_name, email, status, level, position, department, hiring_date
) VALUES 
    ('MGR001', 'Test Manager', 'manager@company.com', 'Active', 'Manager', 'Department Manager', 'Operations', CURRENT_DATE),
    ('EMP001', 'Test Employee', 'employee@company.com', 'Active', 'Employee', 'Staff Member', 'Operations', CURRENT_DATE)
ON CONFLICT (id) DO NOTHING;

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_employees_updated_at BEFORE UPDATE ON employees FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_leaves_updated_at BEFORE UPDATE ON leaves FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_excuses_updated_at BEFORE UPDATE ON excuses FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_overtime_updated_at BEFORE UPDATE ON overtime FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_penalties_updated_at BEFORE UPDATE ON penalties FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_salary_details_updated_at BEFORE UPDATE ON salary_details FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_payroll_updated_at BEFORE UPDATE ON payroll FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- DEPLOYMENT NOTES:
-- 1. This schema is ready for any new Supabase project
-- 2. No permission errors - removed problematic JWT settings
-- 3. Table names match the application code (salary_details NOT salaries)
-- 4. Includes sample users and employees for immediate testing
-- 5. RLS policies are permissive to work with custom authentication
-- 6. Default login credentials:
--    Admin: admin@company.com / admin123 (full access)
--    Admin_1: admin1@company.com / admin123 (limited - no salary/payroll)
--    Manager: manager@company.com / user123
--    Employee: employee@company.com / user123
