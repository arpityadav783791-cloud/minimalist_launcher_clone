package com.example.minimalist_launcher_clone.services

import android.accessibilityservice.AccessibilityService
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class MinimalistAccessibilityService : AccessibilityService() {

    companion object {
        private const val TAG = "MinimalistAccessibility"
    }

    override fun onServiceConnected() {
        super.onServiceConnected()

        Log.d(TAG, "Accessibility Service Connected")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {

        if (event == null) return

        // Package of the app currently on screen.
        val packageName = event.packageName?.toString() ?: return

        Log.d(TAG, "Foreground App: $packageName")

        // We will later use this to:
        // - Mindful Delay
        // - App Blocking
        // - Focus Mode
        // - Usage Tracking
    }

    override fun onInterrupt() {
        Log.d(TAG, "Accessibility Service Interrupted")
    }
}