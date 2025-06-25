# 🚀 HR System Deployment Guide for New Clients

This guide explains how to deploy the HR Management System to a new Supabase project without errors.

## 📋 Quick Deployment Steps

### 1. Create New Supabase Project
1. Go to [Supabase](https://supabase.com)
2. Click "New Project"
3. Choose organization and region
4. Set a strong database password
5. Wait for project creation (1-2 minutes)

### 2. Get Project Credentials
1. Go to **Project Settings > API**
2. Copy these values:
   - **Project URL**: `https://your-project-id.supabase.co`
   - **Anon/Public Key**: `eyJ...` (long string)
   - **Service Role Key**: `eyJ...` (different long string)

### 3. Run Database Schema
1. Go to **SQL Editor** in your Supabase dashboard
2. Copy the entire content of `database-schema-complete.sql`
3. Paste it into the SQL editor
4. Click **Run** to execute

✅ **All tables will be created without permission errors!**

### 4. Update Application Configuration
Edit `supabase.js` file:
```javascript
const SUPABASE_URL = 'https://your-new-project-id.supabase.co';
const SUPABASE_ANON_KEY = 'your-new-anon-key-here';
```

### 5. Test the System
1. Open the application in your browser
2. Login with: `admin@company.com` / `admin123`
3. Try adding an employee
4. Try adding leave/excuse/overtime requests

## 🔧 What's Fixed in This Version

### ✅ **No Permission Errors**
- Removed problematic `app.jwt_secret` setting
- Uses permissive RLS policies for custom authentication

### ✅ **Correct Table Names**
- Uses `salary_details` (not `salaries`)
- All table names match the application code

### ✅ **Complete User System**
- `users` table for authentication
- Sample users created automatically
- Admin/Manager/Employee roles working

### ✅ **Sample Data**
- Default admin user and employee
- Test manager and employee accounts
- Ready to use immediately

## 🔑 Default Login Credentials

| Role | Email | Password | Notes |
|------|-------|----------|-------|
| Admin | admin@company.com | admin123 | Full system access |
| Manager | manager@company.com | user123 | Team management |
| Employee | employee@company.com | user123 | Personal requests |

## 🛠️ Troubleshooting

### Problem: "Permission denied to set parameter"
**Solution**: You're using the old schema. Use `database-schema-complete.sql` instead.

### Problem: "Table 'salaries' doesn't exist"
**Solution**: The application has been fixed to use `salary_details` table.

### Problem: "RLS policy violation"
**Solution**: The new schema uses permissive RLS policies that work with custom authentication.

### Problem: Data not showing in UI
**Solution**: 
1. Check browser console for errors
2. Verify table names match between code and database
3. Ensure users are properly authenticated

## 📊 Database Structure

```
users (authentication)
├── id (matches employee code)
├── email, password
├── name (optional)
└── role (admin/manager/employee)

employees (HR data)
├── id (employee code)
├── full_name, email, position
├── department, status, level
└── personal details

leaves, excuses, overtime, penalties
├── employee_id (references employees.id)
├── employee_name
├── dates, status
└── specific fields per type

salary_details, payroll
├── employee_id (references employees.id)
├── salary information
└── bank details
```

## 🔄 For Existing Projects

If you have an existing project with issues:

1. **Backup your data** first
2. **Drop problematic tables** if needed
3. **Run the complete schema** to recreate everything
4. **Restore your data** if necessary

## 📞 Support

If you encounter issues:
1. Check the browser console for specific errors
2. Verify your Supabase credentials are correct
3. Ensure you're using `database-schema-complete.sql`
4. Test with default login credentials first

---

**✨ This deployment guide ensures your HR system works perfectly with any new Supabase project!**
