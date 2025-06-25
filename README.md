# 🏢 HR Management System

A comprehensive, modern HR management system built with vanilla JavaScript and Supabase. Features complete employee lifecycle management, leave tracking, payroll processing, and multi-role access control.

## ✨ Features

### 👥 **Employee Management**
- Complete employee profiles with personal and professional details
- Employee status management (Active/Inactive) with automatic resign date handling
- Department and position management
- Employee search and filtering
- Comprehensive employee cards with detailed information

### 🏖️ **Leave Management**
- Multiple leave types (Annual, Sick, Casual, Emergency, Maternity/Paternity)
- Dynamic leave balance calculation
- Leave request approval workflow
- Manager and admin approval capabilities
- Real-time leave balance tracking

### ⏰ **Attendance & Time Tracking**
- Excuse request management with time tracking
- Overtime request and approval system
- Penalty tracking and management
- Comprehensive time-based reporting

### 💰 **Payroll & Salary**
- Complete salary management system
- Monthly payroll calculation with automatic overtime and penalty integration
- Payroll history and reporting
- Excel export functionality
- Bank account management

### 🔐 **Multi-Role Access Control**
- **Admin**: Full system access and management
- **Manager**: Team management and approval capabilities  
- **Employee**: Personal profile and request submission

### 📊 **Dashboard & Reporting**
- Real-time analytics and statistics
- Visual charts and graphs
- Comprehensive filtering and search
- Export capabilities

## 🚀 Quick Start

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- [Supabase](https://supabase.com) account
- Local web server (recommended: `http-server` via npm)

### 1. Clone Repository
```bash
git clone https://github.com/ahmedatef569/Al-Riyadah-HR-System.git
cd Al-Riyadah-HR-System
```

### 2. Supabase Setup
1. Create a new project at [Supabase](https://supabase.com)
2. Copy your project URL and anon key from Project Settings > API
3. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
4. Update `.env` with your Supabase credentials:
   ```env
   SUPABASE_URL=https://your-project-id.supabase.co
   SUPABASE_ANON_KEY=your_supabase_anon_key_here
   ```

### 3. Database Setup
Run the database schema in your Supabase SQL editor (see `database-schema.sql`)

### 4. Local Development
```bash
# Install http-server globally (if not already installed)
npm install -g http-server

# Start local server
http-server -p 8080

# Open browser to http://localhost:8080
```

## 🔑 Default Login Credentials

### Admin Account
- **Username**: `admin@company.com`
- **Password**: `admin123`

### Test Manager Account  
- **Username**: `manager@company.com`
- **Password**: `user123`

### Test Employee Account
- **Username**: `employee@company.com` 
- **Password**: `user123`

## 📖 Usage Guide

### For Administrators
1. **Employee Setup**: Add employees through Employee section
2. **Salary Configuration**: Set salary details for payroll processing
3. **Leave Management**: Approve/reject leave requests
4. **Payroll Processing**: Run monthly payroll calculations
5. **System Monitoring**: Use dashboard for insights

### For Managers
1. **Team Overview**: View team members and their status
2. **Approval Workflow**: Approve team leave/overtime/excuse requests
3. **Team Reporting**: Access team-specific analytics

### For Employees
1. **Profile Management**: View and update personal information
2. **Request Submission**: Submit leave, excuse, and overtime requests
3. **Status Tracking**: Monitor request status and leave balances

## 🛠️ Technical Stack

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Styling**: Tailwind CSS
- **Backend**: Supabase (PostgreSQL)
- **Authentication**: Custom implementation with Supabase
- **Date Handling**: Flatpickr
- **Icons**: Font Awesome
- **Charts**: Chart.js (for dashboard analytics)

## 📁 Project Structure

```
hr-management-system/
├── index.html                 # Main application file
├── supabase.js               # Database integration layer
├── site.webmanifest          # Progressive Web App manifest
├── database-schema.sql       # Database setup script
├── SETUP_GUIDE.md           # Detailed setup instructions
├── DEPLOYMENT_CHECKLIST.md  # Deployment guide
├── .env.example             # Environment variables template
├── .gitignore              # Git ignore rules
└── README.md               # This file
```

## 🔒 Security Features

- Row Level Security (RLS) policies in Supabase
- Role-based access control
- Input validation and sanitization
- Secure authentication flow
- Environment variable protection

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in this repository
- Check the `SETUP_GUIDE.md` for detailed instructions
- Review the `DEPLOYMENT_CHECKLIST.md` for deployment help

## 🎯 Roadmap

- [ ] Mobile responsive design improvements
- [ ] Advanced reporting and analytics
- [ ] Email notifications for approvals
- [ ] Integration with external HR systems
- [ ] Advanced role permissions
- [ ] Bulk operations for employee management

---

**Built with ❤️ for modern HR management**
