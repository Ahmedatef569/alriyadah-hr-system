# 🚀 HR Management System Setup Guide

This guide will walk you through setting up the HR Management System from scratch.

## 📋 Prerequisites

- Modern web browser (Chrome, Firefox, Safari, Edge)
- [Supabase](https://supabase.com) account (free tier available)
- Basic understanding of web development
- Local web server (recommended: Node.js with http-server)

## 🔧 Step-by-Step Setup

### 1. Repository Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/hr-management-system.git
cd hr-management-system

# Create your environment file
cp .env.example .env
```

### 2. Supabase Project Creation

1. **Create Account**: Go to [Supabase](https://supabase.com) and sign up
2. **New Project**: Click "New Project"
3. **Project Details**:
   - Organization: Select or create
   - Name: `hr-management-system`
   - Database Password: Generate a strong password
   - Region: Choose closest to your location
4. **Wait**: Project creation takes 1-2 minutes

### 3. Get Supabase Credentials

1. **Navigate**: Go to Project Settings > API
2. **Copy Values**:
   - Project URL: `https://your-project-id.supabase.co`
   - Anon/Public Key: `eyJ...` (long string)

### 4. Configure Application

Edit `supabase.js` and replace the credentials:
```javascript
const SUPABASE_URL = 'https://your-project-id.supabase.co';
const SUPABASE_ANON_KEY = 'your_actual_anon_key_here';
```

### 5. Database Setup

1. **Open SQL Editor**: In Supabase dashboard, go to SQL Editor
2. **Run Schema**: Copy and paste the entire content from `database-schema.sql`
3. **Execute**: Click "Run" to create all tables and policies

### 6. Local Development Server

#### Option A: Using Node.js (Recommended)
```bash
# Install http-server globally
npm install -g http-server

# Start server
http-server -p 8080 -c-1

# Open browser to http://localhost:8080
```

#### Option B: Using Python
```bash
# Python 3
python -m http.server 8080

# Python 2
python -m SimpleHTTPServer 8080
```

#### Option C: Using PHP
```bash
php -S localhost:8080
```

### 7. First Login

1. **Open Application**: Navigate to `http://localhost:8080`
2. **Admin Login**:
   - Username: `admin@company.com`
   - Password: `admin123`

### 8. Initial Configuration

#### Create Test Users
1. **Add Employees**: Go to Employee section
2. **Create Manager**: Add employee with Level = "Manager"
3. **Create Employee**: Add employee with Level = "Employee"
4. **Set Passwords**: Use default password `user123` for testing

#### Configure Salary Details
1. **Go to Salary Section**
2. **Add Salary Details** for each employee
3. **Set Leave Balances** in employee profiles

## 🔒 Security Configuration

### Row Level Security (RLS)

The database schema includes basic RLS policies. For production:

1. **Customize Policies**: Modify RLS policies based on your needs
2. **User Authentication**: Implement proper user authentication
3. **Role-Based Access**: Configure detailed role permissions

### Environment Security

1. **Never Commit**: Ensure `.env` is in `.gitignore`
2. **Production Keys**: Use different keys for production
3. **HTTPS**: Always use HTTPS in production

## 🧪 Testing the Setup

### 1. Employee Management
- [ ] Add new employee
- [ ] Edit employee details
- [ ] Change employee status
- [ ] Verify resign date logic

### 2. Leave Management
- [ ] Submit leave request
- [ ] Approve/reject as admin
- [ ] Check leave balance calculation

### 3. Payroll System
- [ ] Add salary details
- [ ] Run monthly payroll
- [ ] Verify calculations

### 4. Multi-Role Access
- [ ] Login as admin
- [ ] Login as manager
- [ ] Login as employee
- [ ] Verify role-specific features

## 🚨 Troubleshooting

### Common Issues

#### "Supabase connection failed"
- Check your `supabase.js` file configuration
- Verify Supabase project is active
- Confirm API keys are correct

#### "Database tables not found"
- Ensure you ran the complete database schema
- Check Supabase SQL editor for errors
- Verify table creation in Database > Tables

#### "Login not working"
- Check if admin user was created in database
- Verify user accounts table exists
- Check browser console for errors

#### "CORS errors"
- Use a local web server (not file:// protocol)
- Configure Supabase CORS settings if needed

### Getting Help

1. **Check Console**: Open browser developer tools
2. **Review Logs**: Check Supabase logs in dashboard
3. **Database Inspection**: Use Supabase table editor
4. **GitHub Issues**: Create issue with error details

## 🎯 Next Steps

After successful setup:

1. **Customize**: Modify system to match your organization
2. **Security**: Implement production-ready security
3. **Backup**: Set up database backups
4. **Monitoring**: Configure error monitoring
5. **Documentation**: Create user manuals for your team

## 📞 Support

For additional help:
- Review the main README.md
- Create an issue on GitHub
- Review Supabase documentation

---

**Setup complete! Your HR Management System is ready to use.** 🎉
